
 -- Question 1 

 -- List comprehension
replicateList ::Int -> a -> [a]
replicateList n x = [x | i<- [1..n]]

 -- Recursive definition
replicateRec :: Int-> a-> [a]
replicateRec 0  x = []
replicateRec n x = x : replicateRec (n-1) x

 
-- Question 2 - as per notes

--  Question 3 
--  [(1,3),(1,4),(2,3),(2,4)]
 
-- Question 4 
--invalid - [1,[2,4], 3]  (first element is a number, second element is a list of numbers)

--Question 5 
{-['a', 'b', 'c']
Type: [Char] 
('a', 'b', 'c')
Type: (Char, Char, Char)
[tail, init, reverse]
Type: [[a]-> [a]]-}


 --Question 6
 --DEscription of foldr as a higher order function   + 
mySum :: Num a=> [a] -> a
mySum = foldr (+) 0

myProduct :: Num a=> [a] -> a
myProduct = foldr (*) 1


-- Question 7
bools :: [Bool]
bools = [True, False]

nums :: [[Int]]
nums = [ [1, 2, 3], [4, 5, 6, 5] ] 

copy :: a -> (a,a)
copy x = (x, x)


-- Question 8
second :: [a] -> a
second x = head (tail x)

swap :: (a,b) -> (b,a) 
swap (x,y) = (y,x) 

pallindrome :: Eq a => [a] -> Bool
pallindrome a = a ==reverse a

twice :: (a-> a) -> a -> a
twice f x = f (f x)

addOneIfOdd n = case odd n of 
    True -> f n 
    False -> n 
    where f n = n+1

add1IfOdd n = case odd n of 
    True -> (\x->x+1) n 
    False -> n 


addFive x y = (if x > y then x else y)+ 5

addFive'  =( \x y-> if x > y then x+5 else y)  3 4

lam = (\x -> if x <0 then (-x) else x) (-4)

mymax = (\x y -> if x>y then x else y) 14 5

mymin = (\x y -> if x<y then x else y) 4 5
