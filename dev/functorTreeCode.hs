

data Tree a = EmptyTree 
                | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  


instance Functor Tree where  
    fmap f EmptyTree = EmptyTree  
    fmap f (Node x leftsub rightsub) = 
                         Node (f x) (fmap f leftsub) (fmap f rightsub)   
singleton :: a -> Tree a  
singleton x = Node x EmptyTree EmptyTree  
  
treeInsert :: (Ord a) => a -> Tree a -> Tree a  
treeInsert x EmptyTree = singleton x  
treeInsert x (Node a left right)   
    | x == a = Node x left right  
    | x < a  = Node a (treeInsert x left) right  
    | x > a  = Node a left (treeInsert x right)  



flatten :: Tree a ->  [a]
flatten EmptyTree                       = []
flatten (Node x EmptyTree  EmptyTree)   = [x]
flatten (Node x l r )                   = flatten l
                                          ++ [x]
                                          ++ flatten r

easynums = [1,2, 23, 5]
easynumsTree = foldr treeInsert EmptyTree easynums 
--foldr treeInsert EmptyTree 1: (2: [])
-- == 1 treeInsert (2 treeInsert EmptyTree)




nums = [8,6,4,1,7,3,5]
numsTree = foldr treeInsert EmptyTree nums  

-- foldr (+)  0 [1,2,3] 
-- foldr (+)  0 1: (2: (3:[]))  
-- 1 + 2 + 3 + 0

-- foldr (+)  0 [1,2,3] 
-- foldr (+)  0 1: (2: (3:[]))  