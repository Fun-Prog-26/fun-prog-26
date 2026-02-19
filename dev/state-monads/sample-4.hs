
data Tree a = Leaf  |  Node  a (Tree a) (Tree a) 
               deriving Show

repeatTree :: a -> Tree a
repeatTree x =  Node x t t 
                where t = repeatTree x 
takeTree :: Int -> Tree a -> Tree a
takeTree 0 _ = Leaf
takeTree n Leaf = Leaf
takeTree n (Node x l r)  = Node  x (takeTree (n-1) l ) (takeTree (n-1) r )

mapTree :: (a->b) -> Tree a -> Tree b
mapTree f Leaf = Leaf
mapTree f (Node x l r) = Node (f x) (mapTree f l) (mapTree f r)

replicateTree :: Int -> a -> Tree a
replicateTree n = takeTree n . repeatTree


myTree :: Tree Int
myTree = Node  1 (Node 6 (Node 4 (Leaf)  (Leaf))  (Leaf) )  (Node 3 Leaf  Leaf )