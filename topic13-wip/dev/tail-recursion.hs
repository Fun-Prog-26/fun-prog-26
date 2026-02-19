-- tail.hs
factRec :: Int -> Int
factRec 0 = 1
factRec n = n*factRec (n-1)


-- factTailRec ::Int -> Int 
-- factTailRec n = helper n 1 where
--     helper 1 y = y
--     helper x y = helper (x-1) (y*x)


-- int gcd(a,b) {
-- if (a % b == 0) return b;
-- return gcd(b, a % b);
-- }gcd(10,15)


gcdTail :: Int -> Int -> Int
gcdTail a b | (a `mod` b == 0) = b
            | otherwise = gcdTail b  (a `mod` b)

myAdd :: Int -> Int -> Int
myAdd x 0 = x
myAdd 0 y = y
myAdd x y = myAdd (x-1) (y+1)


tailMult :: Int->Int-> Int
tailMult x y  = helperMult x y 0
 where helperMult x y acc  | y ==0 = acc
                           | otherwise = helperMult x (y-1) (acc+x)
recMult :: Int -> Int-> Int
recMult x 1 = x
recMult 1 y = y
recMult x y = x + recMult x (y-1)

factTailRec ::Int -> Int 
factTailRec n = helper n 1 where
       helper 1 acc = acc
       helper x acc = helper (x-1) (acc*x)

sumInts :: [Int] -> Int
sumInts [] = 0
sumInts (n:ns) = n + sumInts ns

sumIntsTail :: [Int] -> Int
sumIntsTail ns  = helper ns 0 where
    helper [] acc = acc
    helper (n:ns) acc = helper ns (acc+n)