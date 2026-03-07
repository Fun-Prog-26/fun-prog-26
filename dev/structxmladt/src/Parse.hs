{-# LANGUAGE OverloadedStrings #-}
module Parse where

import qualified Text.XML as X
import Text.XML.Cursor
import qualified Data.Text as T
import Adts
import Adts (Quiz(..), Question(..), Answer(..), Category(..), QuestionType(..))
import Text.Parsec (parse)
-- was T.Text
parseCategoryType :: [T.Text] -> Category
parseCategoryType (c:_) =
  case c of
    "introduction" ->  Introduction
    "arrays"       ->  Arrays
    "loops"        ->  Loops
    "arraylists"   ->  ArrayLists
    "shopwitharraylists" ->  ShopWitArrayLists
    _              -> NoCategory
parseCategoryType [] = NoCategory

parseQuizCategory :: Cursor -> Category
parseQuizCategory c =
  case attribute "category" c of
    [] -> NoCategory
    xs -> parseCategoryType xs

parseQuiz :: Cursor -> Either String Quiz
parseQuiz root =
  let quizCursor =
        if isLocalName "quiz" root
          then Just root
          else 
            case (root $// laxElement "quiz") of
                 (qc:_) -> --let quizCat = parseCategory (attribute "category" q) in 
                       Just qc --(Quiz  {quizCategory = Loops, quizQuestions = map  (parseQuestion Loops)  (q $/ laxElement "question")})
                 []    -> Nothing
      rquizCategory = parseQuizCategory root
  in case quizCursor of
       Nothing ->
         Left $
           "No <quiz> root found.\n" <>
           "Top-level root element I did find: " <> showRoot root
       Just q  ->
         let qs = q $/ laxElement "question"
         in Right $ Quiz {quizCategory = rquizCategory
         , quizQuestions = map (parseQuestion rquizCategory)  qs} -- (quizCat (map parseQuestion qs))
-- Helper: check if the current node is an element with the given local name
isLocalName :: T.Text -> Cursor -> Bool
isLocalName wanted c =
  case node c of
    X.NodeElement el -> X.nameLocalName (X.elementName el) == wanted
    _              -> False

-- Helper: check if the current node is an element with the given local name, ignoring namespace
showRoot :: Cursor -> String
showRoot c =
  case node c of
    X.NodeElement el -> show (X.elementName el)
    other          -> show other

parseQuestion ::Category -> Cursor -> Question
parseQuestion defCat qc =
  Question
    { qType    = parseQuestionType (attribute "type" qc)
    , qCategory = 
      case attribute "category" qc of 
        [] -> defCat
        xs ->  parseCategoryType xs --(parseCategory (attribute "category" qc))
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
