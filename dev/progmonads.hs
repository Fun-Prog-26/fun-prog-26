--HaskelCraft Chapter 18

import Control.Monad 
import System.IO 

getInt :: IO Integer
getInt = do line <- getLine
            return (read line :: Integer)

sumInts :: Integer -> IO Integer
sumInts s = do 
           n <- getInt
           if n ==0
              then return s
              else sumInts (s + n)

sumAcc :: Int -> [Int] -> Int
sumAcc s [] = s
sumAcc s (n:ns) = if n == 0
                     then s
                     else sumAcc (s + n) ns

sumInteract :: IO ()
sumInteract = 
   do putStrLn "Enter integers one per line"
      putStrLn "These will be summed until 0 is entered"
      sum <- sumInts 0
      putStr "The sum is "
      print sum

whileG :: (a -> IO Bool) -> (a -> IO a) -> (a -> IO a)

whileG cond op x
  = do test <- cond x
       if test
          then do op x
                  whileG cond op x
          else return x
