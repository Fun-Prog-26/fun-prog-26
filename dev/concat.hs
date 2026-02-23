import qualified Data.List as L

myConcate :: [a] -> [a] -> [a]
myConcate [] ys = ys
myConcate xs [] = xs
myConcate  [x] yss = x:yss
myConcate (x:xs) (ys) = x :  xs `myConcate` ys

concat2 :: [a] -> [a] -> [a]
concat2 xs ys = [x | x<- xs, x<- ys]

factors :: Int -> [Int]
factors n = [x | x<- [1..n], n`mod`x == 0 ]

isPrime :: Int -> Bool
isPrime n =  factors n == [1,n]

prime :: Int -> [Int]
prime n = [x | x <- [1..n], isPrime (x) ]

flip' :: (a -> b-> c) -> (b->a-> c)
flip' f = g 
    where 
       g x y = f y x

--not sure this is the correct specification
perfects :: Int -> [Int]
perfects  n = [x | x <- [1..n] , [1,x] == factors x]

isAnagramOf :: String -> String -> Bool
isAnagramOf xs ys= L.sort  ys == L.sort xs