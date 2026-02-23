import Debug.Trace

multby2 :: Num a=> [a] -> [a]
multby2 [] = []
multby2 (x:xs) = x*2 : multby2 xs
 
multby2' :: Num a=> [a] -> [a]
multby2' [] = trace "running on empty" []
multby2' (x:xs) = trace "recursing" x*2 : multby2 xs

--Note use of (Num a, Show a) here - we need to use show. 
multby2'' :: (Num a, Show a)=> [a] -> [a]
multby2'' [] = trace "running on empty" []
multby2'' (x:xs) = trace ("value of x = "  ++ show x)  x*2 : multby2 xs


-- 
-- 

-- insert ::  Ord a => a −> [ a ] −> [ a ]
-- insert x [ ] = [ x ]
-- insert x ( y : ys ) =
--        trace ( "  insert" ++ show x ++ " in " ++ (show ( y : ys ) ) )
--        if x <= y
--            then x : ys
--            else y : insert x ys

sort :: Ord a => [a] -> [a]
sort [] = []
-- sort [x] = [x]
sort ( x : xs ) =  insert x ( sort xs )
insert :: Ord a => a -> [a] -> [a]
insert x [ ] =  [ x ]
insert x ( y : ys ) = if  x <= y   then x : insert y ys   else  y : insert x  ys 

-- sort :: Ord a => [a] -> [a]
-- sort [] = []
-- sort ( x : xs ) = insert x ( sort xs )
-- insert :: Ord a => a -> [a] -> [a]
-- insert x [ ] = [ x ]
-- insert x ( y : ys ) = if  x <= y   then (x : y:  ys)   else y : insert x  ys 