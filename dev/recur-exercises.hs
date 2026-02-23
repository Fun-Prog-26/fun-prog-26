--Recursion - Exercises

myAnd :: [Bool] -> Bool
myAnd [] = True
myAnd (b:bs) = b && myAnd (bs)


drop' :: Integral b => b -> [a] -> [a]
drop' _ [] = []
drop' 0 (x:xs) = x:xs
--drop' n [] = []
drop' n (x:xs) = drop'      (n-1) xs

myConcat :: [[a]] -> [a] 
myConcat []  = []
myConcat (x:xs)  = x ++ (myConcat xs)

myReplicate :: Int -> a-> [a]
myReplicate 0 _ = []
myReplicate n x = x: myReplicate (n-1) x

myNth ::Int -> [a] -> a
myNth 0  (x:xs)       = x
myNth  n (x:xs) = myNth  (n-1) xs

myElem :: Eq a => a -> [a] -> Bool
myElem x [] = False
myElem  x' (x:xs)  | x' == x = True
                   | otherwise = myElem x' xs

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x <= y = x: merge xs (y:ys)
                    | otherwise = y: merge (x:xs) ys
halve :: [a] -> ([a], [a]) 
halve [x] = ([x], [])
halve xs = (firsthalf, secondhalf)
   where 
    firsthalf = take half xs
    secondhalf = drop half  xs
    half = div (length  xs) 2

msort :: Ord a => [a] -> [a]    
msort [] = [] 
msort [x] = [x]
msort xs = merge  (msort left)  (msort right )
    where 
     (left, right) = halve xs
sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum xs

take' :: Int-> [b] -> [b]
take' 0 _ = []
take' _ [] = []
take' n (x:xs) = x: take' (n-1) xs

last' :: [a] -> a
last' [x] = x
last' (_:xs) = last xs

fibonacci :: Integral a => a -> a 
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2) 

mymap :: (a -> b) -> [a] -> [b]
mymap f [] = []
mymap f (x:xs) = f x : mymap f xs

mydouble ::  Int -> Int
mydouble x = 2*x

--nestedreverse :: [String] -> [String]
-- finish here

f :: Int -> [a] -> a
f 0 (x:_) = x
f n (x:y) = f (n-1) y
