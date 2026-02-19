module Types where

import Data.Char (isDigit)

data ValidationResult a
  = Valid a
  | Invalid [String]
  deriving (Show)

-- Similarly define validateName', validateEmail'
