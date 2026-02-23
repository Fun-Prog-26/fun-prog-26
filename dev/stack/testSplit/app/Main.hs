module Main (main) where

import SplitModule (splitOnSpace, splitOnSpace2)

main :: IO ()
main =  do
    print splitOnSpace
    print $ splitOnSpace2 "bye now MAIREAD"
