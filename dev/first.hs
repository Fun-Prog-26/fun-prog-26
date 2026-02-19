data Tree a = Leaf a | Node (Tree a) (Tree a)
              deriving (Show, Read)

halve :: [a] -> ([a], [a])
halve xs = splitAt (length xs `div` 2) xs 

balance ::  [a] -> Tree a
balance [x] = Leaf x
balance xs = Node ( balance ys ) ( balance zs)
             where (ys,zs) = halve xs


ma :: (a-> b) -> [a] -> [b]
ma f [] = [] 
ma f (x:xs) = f x : ma f xs
m :: (a-> b) -> [a] -> [b]
m  f = foldr (f (: ) ) []
double :: Int -> Int
double x = x*2

myAll::(a->Bool) ->[a] -> Bool
myAll p [] = True
myAll p (x:xs) = p x && myAll p xs 


myAnd :: [Bool] -> Bool
-- myAnd[] = True
-- myAnd (x:xs) = x && myAnd xs
myAnd = foldr (&&) True
-- 
mySum :: [Int]-> Int
mySum = foldr (+) 0

