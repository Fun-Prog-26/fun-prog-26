module WorkbookQuestions where

import qualified Data.Map as M

evens :: [a] -> [a]
-- evens = error "evens not implemented"
evens [] = []
evens [_] = []
evens (x:y:xs) = y: (evens xs)

addWhenMod3Is2 :: [Int] -> [Int]
-- addWhenMod3Is2 = error "addWhenMod3Is2 not implemented"
addWhenMod3Is2 []                        = []
addWhenMod3Is2  (x:xs) | (x  `mod` 3 == 2) = (x+3): addWhenMod3Is2 xs
                       | otherwise         = addWhenMod3Is2 xs

reverse_ :: [a] -> [a]
-- reverse_ = error "reverse_ not implemented"
reverse_ []  = []
reverse_ (x:xs) = reverse_ xs ++ [x]

reverseAccum :: [a] -> [a]
-- reverseAccum = error "reverseAccum not implemented"
reverseAccum  list = revHelper [] list
   where revHelper  accum []        = accum
         revHelper  accum (x:xs)    = revHelper (x:accum) xs

specialMultiples :: [Int] -> [Int]
-- specialMultiples = error "specialMultiples not implemented"
specialMultiples [] = []
specialMultiples xs =  [i*x | x<-xs, i<- [2,3,4]]

manyStrings :: [Int] -> [String] -> [String]
--manyStrings = error "manyStrings not implemented"
manyStrings ns xss = concat [replicate n xs |  (n, xs)<- zip ns xss ]

addPairs :: [Int] -> [Int]
--addPairs = error "addPairs not implemented"
addPairs [] = []
addPairs [_] = []
addPairs [x,y] = [x+y]
addPairs (x:y:xs) = (x+y): addPairs xs

listToMap :: [Int] -> M.Map String Int
-- listToMap = error "listToMap not implemented"
listToMap [] = M.empty
listToMap (n:ns) = M.insert (show  n) n ( listToMap ns)

sumWithParity :: [Int] -> Int
sumWithParity = error "sumWithParity not implemented" 

jumpingStairs :: [Int] -> [(String, Int)] -> ([String], [String])
jumpingStairs = error "jumpingStairs not implemented"

fib :: Int -> Int
fib 0 = 0
fib 1  = 1
fib n = fib (n-1) + fib (n-2)

fibT :: Int -> Int
fibT n = helper n 1 0  where
      helper 1 prev prevBut1 =  prev 
      helper n prev prevBut1 = helper (n-1) (prev+prevBut1) prev