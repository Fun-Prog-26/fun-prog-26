

---http://web.cecs.pdx.edu/~sheard/course/funprog/assignments/assign01.html
import Data.Char
mystrlen :: String -> Int
mystrlen s = length s

ncopies:: Int -> a -> [a]
ncopies 0 x = []
ncopies n x = x: ncopies (n-1) x 


{- Write a function which converts a string of digits into an int.
you will need the following predefined function:
     ord ‘1’       --> 49         first char in arg to its ascii code

follow the following "pipeline" analysis when defining your function
"167"  --> ['1','6','7'] --> [49,54,55] --> [1,6,7] --> [(1,100),(6,10),(7,1)]
--> [100, 60, 7] --> 167
(hint: the first function in the pipeline is very simple. why?) -}

cToNum :: Char-> Int
cToNum c = ord c - ord '1' +1

myMult ::   (Int, Int) -> Int
myMult x = fst x * snd x

evalf ::[Int] -> [(Int, Int)]
evalf ns = zip (reverse ns )  [10^x | x <- [0..10] ]

multPairs :: [(Int,Int)] -> [Int]
multPairs = map (\(x,y)-> x*y) 

multPairsList ::[(Int,Int)] -> [Int]
multPairsList xs = [(\(f,s) -> f*s) x | x <- xs]

myPower :: Int -> Int -> Int
myPower x y = x^y

strToNum :: [Char]-> Int
strToNum ns = sum (map myMult  (evalf (map cToNum ns)))


---http://web.cecs.pdx.edu/~sheard/course/funprog/assignments/assign03.html
{- 1) Write a function "wordsL" such that (wordsL "This is a sentence.")
returns ["This", "is","a","sentence."]. It breaks a string into a list
of strings. It breaks the strings (and throws away the separators) at
blanks ( ' ' ), tabs ( '\t' ), and newlines ( '\n' ).  Hint: takeWhile
and dropWhile are very useful.  e.g. (takeWhile even [2,4,5,6,7]) =>
[2,4]. There is a function called words in the prelude that does exactly
this. Write your own version. -}

stripLeadingTokens :: [Char] -> [Char]
stripLeadingTokens [] = [] 
stripLeadingTokens (x:xs)    | x == ' '  || x == '\t' || x == '\n' = stripLeadingTokens(xs)
                             | otherwise                           = x:xs


myWords :: [Char] -> [[Char]]
myWords [] = []
myWords xs = takeWhile (/=' ') xs : myWords (stripLeadingTokens (dropWhile (/= ' ') xs ))


