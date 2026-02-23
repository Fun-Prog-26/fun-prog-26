module Anagram( isAnagram) where

-- import Data.Char (toLower,isSpace,isPunctuation)
import Data.List (sort)
import qualified Data.Text as T



isAnagram :: String -> String ->Bool
isAnagram xs ys = sort tys == sort tys
    where tys = T.pack ys
          

preProcess t = T.toLower t