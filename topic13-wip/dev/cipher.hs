import Data.Char
import Debug.Trace
-- http://shuklan.com/haskell/lec03.html#/0/21

-- ciphers :: [Char] -> Int -> [Char]
-- ciphers [] _ = []
-- ciphers (s:ss) n = (rotate s n) : (ciphers ss n)

rotate :: Char -> Int  -> Char 
rotate c n | isLower c = chr(((ord c + n -97 ) `mod` 26) + 97) 
           | otherwise = c

encode :: Int -> [Char] -> [Char]
encode n xs = [shift  n x | x <-xs]
--Hutton example:r

let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

shift :: Int -> Char -> Char
shift n c   | isLower c = int2let ( (let2int c + n ) `mod`26)
            | otherwise = c

encode' :: Int -> String -> String 
encode' n xs = [shift n x | x <- xs]

table :: [Float]
table = [8.1, 1.5, 2.8, 4.1, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7, 7.5, 1.9, 0.1, 6.0, 6.3, 9.0, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1]

count :: Eq a => a-> [a] -> Int
count x xs = length [ x' | x' <- xs, x==x']
percent :: Int -> Int -> Float
percent n m = (fromIntegral n / fromIntegral m ) * 100

{- lower :: Char -> Char
lower c | isUpper c = toLower c
         | otherwise = c -}

positions :: Eq a => a ->  [a] ->  [Int]
positions x xs =  [i | (x',i) <-  zip xs [0..], x == x']


lowers :: [Char] -> Int
lowers xs = length [x| x <- xs, x >= 'a' && x <= 'z'] 

freqs :: String -> [Float]
freqs  xs = [percent (count x xs) n | x <- ['a'..'z']]
      where n = lowers xs

chisqr :: [Float] -> [Float] -> Float
chisqr os es = sum [((o-e)^2)/e | (o,e) <- zip os es]

rotate' :: Int -> [a] -> [a]
rotate' n xs = drop n xs ++ take n xs

crack :: String -> String 
crack xs = encode (-factor) xs
    where
     factor = head (positions  ( minimum chitab) chitab ) 
     chitab = [chisqr (rotate' n table') table | n <- [0..25]]
     table' = freqs xs

table' :: [Float]
table' = freqs "kdvnhoo lv ixq"

test = [chisqr (rotate' n table') table | n <- [0..25]]

f :: Integer -> Integer -> [Integer]
f num times = [num | t <- [1..times]]

g :: Integer -> Integer -> Integer 
g x 0 = x
g x y = g (x+1) (y-1) 

ms :: Integer -> Integer -> Integer
ms x 0 = x
ms x y = ms (x-1) (y-1)


mu ::Integer -> Integer -> Integer
mu x 1 = x
mu x y =   x + mu x  (y-1) 