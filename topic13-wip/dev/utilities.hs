
 replicateRec::Int-> a-> [a]
 replicateRec 0  x = []
 replicateRec n x = x: replicateRec (n-1) (x)

 filter1:: (a-> Bool) -> [a] -> [a]
 filter1 p li = [x | x<- li, p x]

 zippy :: [a] -> [b] -> [(a,b)]
 zippy [] _ = []
 zippy _ [] = []
 zippy (x:xs) (y:ys) = (x,y) : zippy xs ys

 myElem :: Eq a=> a->[a] ->Bool
 myElem _ [] = False
 myElem lookingFor (x:xs)
    | x == lookingFor = True
    | otherwise = myElem lookingFor xs

 myAnd :: [Bool] -> Bool
 myAnd [] = True
 myAnd (x:xs)
     | x == False = False
     | x == True = myAnd xs

 myConcat :: [[a]] ->[a]
 myConcat [] = []
 myConcat [[x]] = [x]
 myConcat (x:xs) = x ++ myConcat xs 



 myreplicate :: Int ->a -> [a] 
 myreplicate n  x
    | n == 0   = []
    | n == 1   =[x]
    | n > 1    =  x: replicate (n-1) x
 

 itemOf :: [a] -> Int -> a
 itemOf [] _ = error "index out of bounds"
 itemOf (x:xs)  1 = x
 itemOf (x:xs) n =  itemOf xs (n-1)

 itemOf2 :: [a] -> Int -> a
 itemOf2 [] _ = error "index out of bounds"
 itemOf2 (x:xs)  1 = x
 itemOf2 (x:xs) n =  itemOf2 xs (n-1)

 myMerge :: Ord a => [a] -> [a] -> [a]
 myMerge xs [] = xs
 myMerge [] xs = xs
 myMerge (x:xs) (y:ys) 
    | x < y = x : myMerge (xs) (y:ys) 
    | x >= y = y: myMerge (x:xs) (ys)

 halve :: [a] -> ([a], [a])
 halve [] = ([],[])
 halve xs =
     let halfLen = (length (xs)) `div` 2
     in 
     (take halfLen xs, drop halfLen xs)



 mSort :: Ord a=> [a] -> [a]
 mSort [] = []
 mSort [x] = [x]
 mSort xs = myMerge (mSort(fst (halve xs)))  (mSort(snd (halve xs)))

 myReplicate2 :: Int -> a -> [a]
 myReplicate2 0 _ = []
 myReplicate2 1 x = [x]
 myReplicate2 n x = x:myReplicate2 (n-1) (x)
 
 mySum :: [Int] -> Int
 mySum [x] = x 
 mySum (x:xs) = x + mySum xs

 myLast :: [a]-> a
 myLast [x] = x
 myLast (x:xs) = myLast xs



 luhnDouble :: Int-> Int
 luhnDouble n 
     | n*2 > 9 = n*2 -9
     | otherwise = n*2
 
 luhn :: Int -> Int-> Int-> Int -> Bool
 luhn x1 x2 x3 x4 = if  (((luhnDouble x1) + (luhnDouble x3) + x2 + x4) `mod` 10 )== 0 then True else False


 -- list comprehension exercises
 grid :: Int-> Int-> [(Int,Int)]
 grid  m n = [ (i,j) | i<- [0..m], j<- [0..n]]

 square :: Int -> [(Int, Int)]
 square n = [(i,j)| (i,j)<- grid n n, i/=j]


 myReplicate ::Int -> a -> [a]
 myReplicate n x = [x | i<- [1..n]]