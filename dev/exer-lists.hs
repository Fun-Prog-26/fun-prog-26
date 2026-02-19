-- Exercises - List comprehensions
import Data.Char
cubes :: [Int]
cubes = [x^3 | x <- [1..10]]

myConstFunc :: [(Int, Int)]
myConstFunc = [(x, 1)| x <- [1..5]]
l1 :: [(Int, Int)]
l1 = [(x, y) | x <-[1..3], y<- [4..5]]

l2 :: [(Int, Int)]
l2 = [(x, y) | y<- [4..5], x <-[1..3]]

l3 :: [(Int, Int)]
l3 = [(y, x) | x <-[1..3], y<- [4..5]]


leapYears :: [Int]
leapYears = [x | x<- [1900..2000], (x `mod`4 == 0 && x `mod`100 /= 0) || x `mod` 400 ==0 ]
mySquares :: [(Int, Int)]
mySquares = [(x, x^2) | x <- [1..10]]

isEven :: Integer -> Bool
isEven n = (n `mod`2 ==0)
ex3::[Integer]
ex3 = [2*n | n <- [2,4,7], isEven n, n>3]

doubleAll :: [Integer] -> [Integer]
doubleAll ns = [n*2 | n<-ns]

capitalize :: String -> String
capitalize xs = [toUpper(c) | c<- xs ]

sigma :: Int
sigma = sum [x^2 | x <- [1..100]]

sigma' :: Int-> Int
sigma' n = sum[x^2 | x <- [1..n]]

matches :: Integer -> [Integer] -> [Integer]
matches x xs = [x' | x' <- xs, x' == x]

elem':: Integer -> [Integer] -> Bool
elem' x xs = matches x xs  /= []   

length' :: [a] -> Int
length' xs = sum [1 | _ <- xs]

count :: Eq a => a -> [a] -> Int
count x xs = length [x' | x' <- xs, x == x']

grid :: Int-> Int -> [(Int, Int)]
grid x y = [(x', y')| x' <- [0..x], y'<- [0..y]]

square :: Int -> [(Int, Int)]
square x = [(x', y')| x'<- [0..x], y' <- [0..x], x' /= y']

myReplicate :: Int -> a -> [a]
myReplicate x y = [y| _ <- [1..x]]

pyths ::Int -> [(Int, Int, Int)]
pyths n =  [(x, y,z) | x <- [1..n], y<- [1..n], z <- [1..n], x^2 + y^2 == z^2]


factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x ==0]

perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], x == sum (factors x) - x]

perfects' :: Int -> [Int]
perfects' n = [x | x <- [1..n], x == sum ( init (factors x))]