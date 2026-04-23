module Main where
import Shuffle
import Test.QuickCheck
import System.IO.Unsafe (unsafePerformIO)   

prop_checkShuffle :: [Int] -> Bool
prop_checkShuffle xs =
  let shuffled = unsafePerformIO (Shuffle.shuffle xs)
  in length shuffled == length xs && all (`elem` shuffled) xs


main :: IO ()
main = quickCheck prop_checkShuffle
