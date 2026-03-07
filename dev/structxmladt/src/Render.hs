{-# LANGUAGE OverloadedStrings #-}
 
module Render where

import qualified Data.Text as T
import Adts
import Data.Text.Internal.Read (T(T))
import Text.PrettyPrint (render)
-- for use in CDATA sections, we need to render the formatting as well, so we replace the HTML entities with their markdown equivalents
renderFormatting :: T.Text -> T.Text
renderFormatting =
      T.replace "&lt;code&gt;" "`"
    . T.replace "&lt;/code&gt;" "`"
    . T.replace "&quot;" "\""
    . T.replace "&lt;" "<"
    . T.replace "&gt;" ">"
    . T.replace "&lt;em&gt;" "**"
    . T.replace "&lt;/em&gt;" "**"
    . T.replace "&lt;code&gt;" "`"
    . T.replace "&lt;/code&gt;" "`"
    . T.replace "&lt;pre&gt;" "\n \n~~~"
    . T.replace "&lt;/pre&gt;" "~~~ \n"
    . T.replace "&lt;pre&gt;&lt;code&gt;" "\n~~~ \n"
    . T.replace "&lt;/code&gt;&lt;/pre&gt;" "\n ~~~ \n"
 

renderQuiz :: Quiz -> T.Text
renderQuiz Quiz {quizCategory = cat, quizQuestions = qs}=
  T.unlines (zipWith renderQ [1 :: Int ..] qs)

renderQ :: Int -> Question -> T.Text
renderQ i q = renderFormatting $
  T.unlines $
    [ "## Q" <> T.pack (show i) <> " (" <> renderCategory (qCategory q) <>  ", " <> renderQT (qType q) <> ")"
    , maybe "_(no name)_" id (qName q)
    , ""
    , maybe "_(no question text)_" id (qText q)
    , ""
    ]
    ++ concatMap renderANoFeedback (qAnswers q)
    ++ [""]

renderQT :: QuestionType -> T.Text
renderQT MultiChoice      = "multichoice"
renderQT TrueFalse        = "truefalse"
renderQT ShortAnswer      = "shortanswer"
renderQT (UnknownType t)  = "unknown:" <> t

renderCategory :: Category -> T.Text
renderCategory Introduction = "introduction"
renderCategory Arrays       = "arrays"
renderCategory Loops        = "loops"
renderCategory ArrayLists   = "arraylists"
renderCategory ShopWitArrayLists = "shopwitharraylists"
renderCategory NoCategory   = "no category"

renderA :: Answer -> [T.Text]
renderA a =
  [ "- [" <> T.pack (show (answerFraction a)) <> "%] " <> answerText a
  , case answerFeedback a of
      Nothing -> "  - _no feedback_"
      Just f  -> "  - " <> f
  ]

renderANoFeedback :: Answer -> [T.Text]
renderANoFeedback a =
  [ "- [  ] " <> answerText a
  
  ]