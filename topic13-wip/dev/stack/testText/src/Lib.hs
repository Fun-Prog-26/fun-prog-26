{-# LANGUAGE OverloadedStrings #-}


module Lib where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified Data.Sort as S

preprocess :: String -> String
preprocess xs = T.unpack (T.toLower (T.strip (T.pack xs))  )
    -- putStrLn "Enter a line of text:"
    -- input <- TIO.getLine   -- Read a line of text from the user
    -- let uppercasedText = T.toUpper input  -- Convert the text to uppercase
    -- TIO.putStrLn uppercasedText  -- Print the uppercase text back to the user

isPalindrome :: String -> Bool
isPalindrome s = s == reverse s


isAnagram :: String -> String ->  Bool
isAnagram xs ys  = S.sort (T.pack xs) == S.sort (T.pack ys)
