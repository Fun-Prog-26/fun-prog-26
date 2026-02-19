{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import Lib

main :: IO ()
main = do 
    putStrLn "Enter a line of text:"
    input <- getLine   -- Read a line of text from the user
    let preprocessedText = preprocess input
    if isPalindrome preprocessedText
        then putStrLn "Yes!"
        else putStrLn "No."
