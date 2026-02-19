add1 :: Int -> Int
add1 x = x+1

always0 :: Int -> Int
always0 _ = 0

always0' ::  Int
always0'= 0

subtract' :: Int -> Int -> Int
subtract' x y = x-y

addmult :: Int -> Int -> Int -> Int
addmult x y z = (x+y) * z

greaterThan0 :: Int -> String
greaterThan0 n = if n>0 then "Yes" else "No!"

pushOut :: Int -> Int
pushOut n  = if n > 0 then n+1 
             else if n < 0 then n-1
             else 0
             
pushOut' :: Int -> Int
pushOut' n   | n > 0     = n+1 
            | n < 0     = n-1
            | otherwise =  0


