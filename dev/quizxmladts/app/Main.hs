{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Text.XML as X
import Text.XML.Cursor
import qualified Data.Text as T

-- =========================
-- 1) Domain ADTs (your model)
-- =========================

data Quiz = Quiz
  { quizQuestions :: [Question]
  } deriving (Show, Eq)

data QuestionType
  = MultiChoice
  | TrueFalse
  | ShortAnswer
  | UnknownType T.Text
  deriving (Show, Eq)

data Answer = Answer
  { answerFraction :: Int
  , answerText     :: T.Text
  , answerFeedback :: Maybe T.Text
  } deriving (Show, Eq)

data Question = Question
  { qType      :: QuestionType
  , qName      :: Maybe T.Text
  , qText      :: Maybe T.Text
  , qAnswers   :: [Answer]
  } deriving (Show, Eq)

-- =========================
-- 2) Decode: Cursor -> ADTs
-- =========================




parseQuiz :: Cursor -> Either String Quiz
parseQuiz root =
  let quizCursor =
        if isLocalName "quiz" root
          then Just root
          else case (root $// laxElement "quiz") of
                 (q:_) -> Just q
                 []    -> Nothing
  in case quizCursor of
       Nothing ->
         Left $
           "No <quiz> root found.\n" <>
           "Top-level root element I did find: " <> showRoot root
       Just q  ->
         let qs = q $/ laxElement "question"
         in Right (Quiz (map parseQuestion qs))

isLocalName :: T.Text -> Cursor -> Bool
isLocalName wanted c =
  case node c of
    X.NodeElement el -> X.nameLocalName (X.elementName el) == wanted
    _              -> False

showRoot :: Cursor -> String
showRoot c =
  case node c of
    X.NodeElement el -> show (X.elementName el)
    other          -> show other

parseQuestion :: Cursor -> Question
parseQuestion qc =
  Question
    { qType    = parseQuestionType (attribute "type" qc)
    , qName    = firstText (qc $/ element "name" &/ element "text")
    , qText    = firstText (qc $/ element "questiontext" &/ element "text")
    , qAnswers = map parseAnswer (qc $/ element "answer")
    }

parseQuestionType :: [T.Text] -> QuestionType
parseQuestionType (t:_) =
  case t of
    "multichoice" -> MultiChoice
    "truefalse"   -> TrueFalse
    "shortanswer" -> ShortAnswer
    other         -> UnknownType other
parseQuestionType [] =
  UnknownType "(missing)"

parseAnswer :: Cursor -> Answer
parseAnswer ac =
  Answer
    { answerFraction = parseFraction (attribute "fraction" ac)
    , answerText     = T.concat (ac $/ element "text" &/ content)
    , answerFeedback = firstText (ac $/ element "feedback" &/ element "text")
    }

parseFraction :: [T.Text] -> Int
parseFraction (x:_) =
  case reads (T.unpack x) of
    [(n,"")] -> n
    _        -> 0
parseFraction [] = 0

-- Helper: take the first textual node if present
firstText :: [Cursor] -> Maybe T.Text
firstText (c:_) = Just (T.concat (c $/ content))
firstText []    = Nothing

-- =========================
-- 3) Render: ADTs -> Markdown
-- =========================

renderQuiz :: Quiz -> T.Text
renderQuiz (Quiz qs) =
  T.unlines (zipWith renderQ [1 :: Int ..] qs)

renderQ :: Int -> Question -> T.Text
renderQ i q =
  T.unlines $
    [ "## Q" <> T.pack (show i) <> " (" <> renderQT (qType q) <> ")"
    , maybe "_(no name)_" id (qName q)
    , ""
    , maybe "_(no question text)_" id (qText q)
    , ""
    ]
    ++ concatMap renderA (qAnswers q)
    ++ [""]

renderQT :: QuestionType -> T.Text
renderQT MultiChoice      = "multichoice"
renderQT TrueFalse        = "truefalse"
renderQT ShortAnswer      = "shortanswer"
renderQT (UnknownType t)  = "unknown:" <> t

renderA :: Answer -> [T.Text]
renderA a =
  [ "- [" <> T.pack (show (answerFraction a)) <> "%] " <> answerText a
  , case answerFeedback a of
      Nothing -> "  - _no feedback_"
      Just f  -> "  - " <> f
  ]

-- =========================
-- 4) Main
-- =========================

main :: IO ()
main = do
  let inFile  = "iteration-loops-15q.xml"
  let outFile = "iteration-loops-15q.md"

  doc <- X.readFile X.def inFile
  let root = fromDocument doc

  case parseQuiz root of
    Left err -> error err
    Right quiz -> do
      let md = renderQuiz quiz
      writeFile outFile (T.unpack md)
      putStrLn ("Wrote: " <> outFile)