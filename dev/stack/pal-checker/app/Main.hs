module Main (main) where

import Palindrome (isPalindrome)


main :: IO ()
main = do 
        putStrLn "Enter a string to check if it is a palindrome"
        input <- getLine
        if (isPalindrome input) then putStrLn "Yes, it is a palindrome" else putStrLn "No, it's not a palindrome"
 
        putStrLn "Done"