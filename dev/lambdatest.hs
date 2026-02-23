myAdd :: Num a => a-> a-> a
myAdd  = \x -> (\y -> x+y)
mySubtract = \x -> (\y -> x -y)
myMult  = \x -> (\y -> x *y)
myMult3 = \x -> (\y -> (\z -> x * y * z))
myMultByTwo = myMult3 2
myMultByTwo_2 = myMult 2
myOtherAdd :: Num a => a -> a -> a
myOtherAdd a b = a + b

myOtherAddToThree = myOtherAdd 3

addOneIfOdd2 n = case odd n of 
    True -> (\n -> n+1) n 
    False -> n
addOneIfOdd n = case odd n of 
    True -> f n 
    False -> n 
    where f n = n + 1
addFive x y = (if x > y then x else y) + 5
addFive2  :: Int -> Int -> Int
addFive2 = (\x->( \y -> case (x>y) of
    True -> x 
    False -> y))
-- {-# LANGUAGE LambdaCase #-}

-- f = \k -> case k
--        _| k < 0     -> "negative"
--         | k == 0    -> "zero"
--         | otherwise -> "positive"

mth :: Int -> Int -> Int -> Int
mth x y z = x*y*z

-- mth x y = \z -> z * x * y

-- mth x = \y -> \z -> x * y* z

-- mth = \x -> \y -> \z -> x * y * z

mymult1 = (\x -> \y -> \z -> x * y * z) 2

mymult2 = (\x y z -> x*y*z) 2 3 4 

tryIf x y = (if x > y then x else y) + 5

tryIf2 = \x -> \y -> (if x > y then x else y) + 5

myFlip f = \x -> \y -> f y x


myAbs = \x -> (if x>=0 then x else -x) 
myMax :: Ord a => a -> a-> a
myMax = \x -> \y -> (if x>=y then x else y)

