--topic 09 - declaring types and classes
data  Tree a = EmptyTree | Node (Tree a) a (Tree a) 
    --   deriving (Eq, Show)

leaves:: Tree a -> Int

leaves EmptyTree   = 0
leaves (Node l  el r) = leaves l + leaves r + 1
-- balanced:: Tree a -> Bool
-- balanced EmptyTree   = True
-- balanced (Node l a r) = abs (leaves l - leaves r) <= 1
--                          && balanced l && balanced r

depth :: Tree a -> Int
depth EmptyTree = 0
depth ( Node l a r ) = max (1 + depth l) 1 + depth r
myTree :: Tree Int
myTree =  Node EmptyTree 2 (Node EmptyTree 4 (Node EmptyTree 5 EmptyTree))

inc :: [Int] -> [Int]
inc xs = [x+1 | x <- xs]

evens :: [Int] -> [Int]
evens xs = [x | x<- xs, x `mod`2 == 0]

sorted :: [Int]-> Bool
sorted [x] = True
sorted (x:y:xs) = x<=y && sorted (y:xs)

remove :: Int -> [Int] -> [Int]
remove x xs = [y | y<- xs , y /= x]

elem' :: Int ->  [Int] -> Bool
elem' x xs = remove x xs /= xs

addTree :: Tree Int -> Int
addTree EmptyTree = 0 
addTree (Node l x r) = addTree l + x + addTree r

balanced :: Tree [a] -> [a]
balanced (Node l x r) = balanced l ++ x ++ balanced r
isSorted :: (Ord a) => [a] -> Bool
isSorted [] = True
isSorted [x] = True
isSorted (x:y:xs) = x <= y && isSorted (y:xs)

balancedCheck :: Ord a => [a] -> Bool
balancedCheck xs    | isSorted xs == True = True
                    | otherwise = False

addTree :: Num p => Tree p -> p
addTree EmptyTree = 0
addTree (Node l x r) = addTree l + x + addTree r
