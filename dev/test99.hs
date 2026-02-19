import Debug.Trace

multby2 :: Num a=> [a] -> [a]
multby2 [] = []
multby2 (x:xs) = x*2 : multby2 xs
 
 safetail ::[a]-> [a]
 safetail [] = []
 safetail  (_:xs) = xs

 safetail2 :: [a] -> [a]
 safetail2 xs = if null xs then [] else tail xs


 safetail3 :: [a] -> [a]
 safetail3 xs 
   | null xs  = []
   | otherwise = tail xs

 myOr :: Bool-> Bool -> Bool
 myOr  x y =
   if x then True else if y then True else False 

 myOr2 :: Bool-> Bool-> Bool
 myOr2 True x = True
 myOr2 x True = True 
 myOr2 x y = False

 myOr3 :: Bool-> Bool-> Bool
 myOr3 x y 
   | x == True = True
   | y == True = True
   | otherwise = False
 
 pyths :: Int ->[(Int, Int, Int)]
 pyths n = [(x,y,z) |  x<- [1..n], y<- [1..n], z<-[1..n], x^2+y^2 == z^2]


 factors :: Int -> [Int]
 factors n = [x | x<- [1..n], n `mod` x == 0 ]

 perfects :: Int -> [Int]
 perfects  n = [x | x <- [1..n] , x == sum (factors x) - x]

 scalar :: [Int]->[Int]->Int
 scalar [] [] = 0
 scalar (x:xs) (y:ys) = x*y + scalar xs ys

 scalar2 :: [Int]->[Int]->Int
 scalar2 xs ys = sum [x*y | (x,y) <- zip xs ys] 








