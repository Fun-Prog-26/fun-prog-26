module Main where

import Prelude hiding (reverse)
import Reverse
import Test.QuickCheck

prop_reverseTwice :: [Int] -> Bool
prop_reverseTwice xs =
  reverse (reverse xs) == xs

main :: IO ()
main = quickCheck prop_reverseTwice