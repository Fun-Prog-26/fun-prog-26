insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) = if x <= y then x: (y:ys)  else y : insert x ys

isort :: [Int]-> [Int]
isort [] = []
isort (x:xs) = insert (x) (isort xs) 


smaller :: Int-> [Int]-> [Int]
smaller n li = [x | x <- li, x < n]

larger :: Int-> [Int]-> [Int]
larger n li = [x | x <- li, x > n]


qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) = qsort (smaller x xs)
               ++ [x]
               ++ qsort (larger x xs)

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) = if x <=y then x: (merge (xs) (y:ys))
                      else y : (merge (x:xs) ys)

mSort :: [Int]-> [Int]
mSort [] = []
mSort [x] = [x]
mSort  xs = merge (mSort left) (mSort right)
            where (left, right) = splitAt ((length xs) `div` 2) (xs)


fst ::(a,b) -> a
fst (x,y) = x