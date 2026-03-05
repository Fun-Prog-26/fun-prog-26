{-# LANGUAGE OverloadedStrings #-}

-- stack script --resolver lts-22.33
--   --package xml-conduit
--   --package text
--   --package bytestring

import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Text.XML as X
import Text.XML.Cursor  
-- --------
-- Helpers
-- --------

-- Get the first <text>...</text> under a given tag (like <name><text>..</text></name>)
firstTextUnder :: X.Name -> Cursor -> T.Text
firstTextUnder tag c =
  case c $/ element tag &/ element "text" of
    (t:_) -> T.concat (t $// content)
    []    -> ""
 
-- Get all text content under a cursor (including CDATA), concatenated.
cursorText :: Cursor -> T.Text
cursorText c = T.concat (c $// content)

-- Get first <questiontext><text>..</text></questiontext>
questionPrompt :: Cursor -> T.Text
questionPrompt q =
  case q $/ element "questiontext" &/ element "text" of
    (t:_) -> cursorText t
    []    -> ""

-- Get the "type" attribute of <question type="...">
questionType :: Cursor -> T.Text
questionType q = T.concat (attribute "type" q)

-- Read "fraction" attribute from <answer fraction="100">
answerFraction :: Cursor -> T.Text
answerFraction a = T.concat (attribute "fraction" a)

-- Parse a fraction attribute safely; defaults to 0
fractionValue :: T.Text -> Double
fractionValue t =
  case reads (T.unpack (T.strip t)) of
    [(x, "")] -> x
    _         -> 0

-- Compute max fraction to mark correct answers (typically 100)
maxFraction :: [Cursor] -> Double
maxFraction ans =
  maximum (0 : [fractionValue (answerFraction a) | a <- ans])

-- --------
-- Rendering
-- --------

renderQuestion :: Int -> Cursor -> T.Text
renderQuestion i q =
  let qType = questionType q
      name  = firstTextUnder "name" q
      prompt = questionPrompt q

      answers = q $/ element "answer"
      best    = maxFraction answers

      renderAnswer :: Int -> Cursor -> [T.Text]
      renderAnswer j a =
        let letter   = T.singleton (toEnum (fromEnum 'A' + j) :: Char)
            fracT    = answerFraction a
            frac     = fractionValue fracT
            aText    =
              case a $/ element "text" of
                (t:_) -> cursorText t
                []    -> ""

            fbText =
              case a $/ element "feedback" &/ element "text" of
                (t:_) -> cursorText t
                []    -> ""

            mark = if frac > 0 && frac == best then " ✅" else ""
            line1 = "- " <> letter <> ". " <> aText <> mark
            line2 = if T.null (T.strip fbText)
                    then []
                    else ["  - _Feedback_: " <> fbText]
        in line1 : line2

      mdAnswers =
        if null answers
          then ["_No answers found._"]
          else
            ["**Options**", ""] <>
            concat [ renderAnswer j a | (j, a) <- zip [0..] answers ]

      header =
        if qType == "multichoice"
          then "## Q" <> T.pack (show i) <> ". " <> name
          else "## Q" <> T.pack (show i) <> ". " <> name <> " (" <> qType <> ")"
  in T.unlines $
       [header, ""]
       <> (if T.null (T.strip prompt) then [] else [prompt, ""])
       <> mdAnswers
       <> [""]

renderQuiz :: [Cursor] -> T.Text
renderQuiz qs =
  let title = "# Iteration & Loops Quiz (from Moodle XML)\n\n> Generated from Moodle XML.\n"
      body  = T.concat [ renderQuestion i q | (i, q) <- zip [1..] qs ]
  in title <> "\n" <> body

-- --------
-- Main
-- --------

main :: IO ()
main = do
  -- Adjust input/output paths as needed
  let inFile  = "iteration-loops-15q.xml"
  let outFile = "iteration-loops-15q.md"

  doc <- X.readFile X.def inFile
  print (X.elementName (X.documentRoot doc))
  let cur = fromDocument doc
      quizCursor =
        case cur $/ element "quiz" of
          (q:_) -> q
          []    -> error "No <quiz> root found"
      questions = cur $/ element "question"
      
  print (length questions)
  -- Moodle structure: <quiz><question ...>...</question></quiz>

  let md = renderQuiz questions
  print md
  T.writeFile outFile md

  putStrLn ("Wrote " <> outFile <> " (" <> show (length questions) <> " questions)")