-- =========================
-- 1) Domain ADTs (your model)
-- =========================
module Adts where

import qualified Data.Text as T

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