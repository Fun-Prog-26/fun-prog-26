--topic 09 - declaring types and classes
data  Tree a = EmptyTree | Node (Tree a) a (Tree a) 
    --   deriving (Eq, Show)

sumTree :: Tree Integer -> Integer
sumTree EmptyTree = 0 
sumTree (Node n) = n
sumTree (Node n xs) = n + (sumTree x) + (sumTree xs)



-- balanced :: Tree a -> Bool
-- balanced (EmptyTree _ ) = True
-- balanced (Node left right) =