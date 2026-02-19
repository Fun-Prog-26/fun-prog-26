module Palindrome where

-- import Data.Text (Text)
import qualified Data.Text as T

isPalindrome :: String -> Bool
isPalindrome xs = T.toLower(T.pack xs) == T.reverse (T.toLower(T.pack xs)) -- T.pack xs == reverse xs