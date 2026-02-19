
import Data.Char

cipher :: [Char] -> Int -> [Char]
cipher [] _ = []
cipher (s:ss) n = (rotate s n) : (cipher ss n)

rotate :: Char -> Int -> Char
rotate c 0 = c
rotate c n = int2letter ( mod ((letter2int c) + n) 26 )

letter2int c = ord c - 97
int2letter n = chr (n + 97)