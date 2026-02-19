module Palindrome where

isPalindrome :: String -> Bool
isPalindrome xs = xs == reverse xs
  