module Main (main) where

import Split.LibSplit (splitOnSpace, splitOnSpaceWithInput)

main :: IO ()
main = do 
    print splitOnSpace 
    putStrLn "Now call another function with input from keyboard"
    input <- getLine
    print (splitOnSpaceWithInput input)
    putStrLn "Done"

