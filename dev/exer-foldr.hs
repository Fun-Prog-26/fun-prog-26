---exer-foldr.hs  
-- from http://www.cantab.net/users/antoni.diller/haskell/answers/ans06.pdf
sumsq1 :: Integral a => a -> a
sumsq1 n = foldr op 0 [1..n]
           where op :: Num a => a -> a -> a
                 op x y = x*x + y

lengthr :: [Int] -> Int
lengthr = foldr (\x y -> 1 + y) 0


minlistr ::  [Int] -> Int
minlistr  = foldr1 min


mysum :: [Int]-> Int
mysum = foldr (\x y -> x + y) 0

mylength ::[a] -> Int
mylength = foldr (\x y -> 1 + y) 0

myreverse :: [a] -> [a]
myreverse = foldr (\x y -> y ++ [x]) []

atfront :: a -> [[a]] -> [[a]]
atfront x = map (x:) 

-- aux :: Eq a => a -> [a] ->  [a]
-- aux x ys | x `elem` ys = []
--          | otherwise   = [x]
myremove :: Eq a => [a] -> [a] -> [a]
myremove xs  =  foldr (\y processed -> (if y `elem`xs then [] else [y]) ++ processed)  [] 
                where aux :: Eq a => a -> [a] ->  [a]
                      aux x ys | x `elem` ys = []
                                   | otherwise   = [x]

-- filter' :: (a-> Bool) ->  [a] -> [a]
-- filter' p  xs = foldr (\x xs -> if p x then x:xs else xs) [] xs

remdupsr :: Eq a => [a] -> [a]
remdupsr []     = []
remdupsr ys = foldr joinr [] ys

joinr :: Eq a => a -> [a] -> [a]
joinr x []             = [x]
joinr x xs
        | x == head xs = xs
        | otherwise    = [x] ++ xs


remdups1 xs = foldr op [] xs where
 op x ys
  | ys == [] = [x]
  | x == head ys = ys
  | otherwise = x:ys
remdups2 (a:xs) = foldr op [a] xs where
 op x ys
   | 
   | x == head ys = ys
   | otherwise = x:ys