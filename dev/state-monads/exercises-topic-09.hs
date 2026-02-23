--topic 09 - declaring types and classes
data Tree a = Leaf a | Node (Tree a) (Tree a) 

leaves:: Tree a -> Int
leaves (Leaf _)   = 1
leaves (Node l r) = leaves l + leaves r
balanced:: Tree a -> Bool
balanced (Leaf _)   = True
balanced (Node l r) = abs (leaves l - leaves r) <= 1
                         && balanced l && balanced r

depth :: Tree a -> Int
depth (Leaf _) = 0
depth ( Node l r ) = max (1 + depth l) 1 + depth r
myTree :: Tree Int
myTree = Node (Node (Node (Leaf 2) (Leaf 3)) (Leaf 4) ) (Leaf 5)

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