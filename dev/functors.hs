import Debug.Trace
import Data.Char
import Data.List

--data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  

-- singleton :: a -> Tree a  
-- singleton x = Node x EmptyTree EmptyTree  
  
-- treeInsert :: (Ord a) => a -> Tree a -> Tree a  
-- treeInsert x EmptyTree = singleton x  
-- treeInsert x (Node a left right)   
--     | x == a = Node x left right  
--     | x < a  = Node a (treeInsert x left) right  
--     | x > a  = Node a left (treeInsert x right)  
data Tree2 a =  EmptyTree2
               | Node2 a (Tree2 a) (Tree2 a) 
                    deriving (Show,Read,Eq) 

data Tree a = 
              EmptyTree 
            | Node (Tree a) a (Tree a)  deriving (Show, Read, Eq)  

occurs x (Node l y r) | x == y = True
                      | x < y  = occurs x l
                      | x > y    = occurs x r

treeInsert :: (Ord a) => a -> Tree a -> Tree a  
treeInsert x EmptyTree = Node  EmptyTree x EmptyTree  
  
treeInsert x (Node left a right)   
 --   | x == a = trace ( "Equals" ) Node left x  right  
    | x <= a  = Node  (treeInsert x left) a right  
    | x > a  =  Node  left  a (treeInsert x right)  

flatten :: Tree a ->  [a]
flatten EmptyTree    = []
flatten (Node EmptyTree x EmptyTree)     = [x]
flatten (Node l x r) = flatten l
                       ++ [x]
                       ++ flatten r

data Frank a b  = Frank {frankField :: b a} deriving (Show)  
data Barry t k p = Barry { yabba :: p, dabba :: t k }  
instance Functor (Barry a b) where  
    fmap f (Barry {yabba = x, dabba = y}) = Barry {yabba = f x, dabba = y} 

-- class (Functor f) => Applicative f where  
--         pure :: a -> f a  
--         (<*>) :: f (a -> b) -> f a -> f b  

-- type AssocList k v = [(k, v)]
-- type IntMap v = Map Int v
-- -- 

phoneBook :: [(String, String)]
phoneBook =
    [("betty", "555-2938")
    ,("bonnie", "452-2928")
    ,("patsy", "493-2928")
    ,("lucille", "205-2928")
    ,("wendy", "939-8282")
    ,("penny", "853-2492")
    ]
findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
--findKey key xs = foldr (\(k, v) acc -> if key == k then Just v else acc) Nothing xs
findKey _ [] = Nothing
findKey key ((k, v):xs) = if key == k then Just v else findKey key xs


myInc :: [Int] -> [Int]
myInc xs = map (+1) xs

myInc2 :: (Functor f) => f Int ->  f Int
myInc2 xs = fmap (+1) xs

nums = [8,6,4,1,7,3,5]
numsTree = foldr treeInsert EmptyTree2 nums  
