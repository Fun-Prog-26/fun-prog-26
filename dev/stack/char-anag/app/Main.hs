module Main where
import  Anagram 



main :: IO ()
main = do
  print "Enter two words  and I'll let you know if they are anagrams of each other!"
  word1 <- getLine
  word2 <- getLine
  let response = if isAnagram  word1 word2
                 then "it is!"
                 else "it's not!"
  print response
