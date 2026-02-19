{-# LANGUaGE OverloadedStrings #-}

module Lib
    ( isPalindrome,
      isAnagram
    ) where

import qualified Data.Text as T
import Data.Char (toLower, isSpace, isPunctuation)

import Data.List as S

stripWhiteSpace :: T.Text -> T.Text
stripWhiteSpace text = T.filter (not . isSpace) text 

stripPunctuation :: T.Text -> T.Text
stripPunctuation text = T.filter (not . isPunctuation) text 

preProcess :: T.Text -> T.Text
preProcess = stripWhiteSpace . stripPunctuation . T.toLower

isPalindrome :: T.Text -> Bool
isPalindrome text = cleanText == T.reverse cleanText 
    where cleanText = preProcess text

isAnagram :: String -> String -> Bool
isAnagram xs ys = S.sort xs == S.sort ys 