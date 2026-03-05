{-# LANGUAGE OverloadedStrings #-}
 
module Render where

import qualified Data.Text as T
import Adts

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
    ++ concatMap renderANoFeedback (qAnswers q)
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

renderANoFeedback :: Answer -> [T.Text]
renderANoFeedback a =
  [ "- [  ] " <> answerText a
  
  ]