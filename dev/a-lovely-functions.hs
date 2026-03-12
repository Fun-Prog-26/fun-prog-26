-- clamp a number between 0 and 1 - 
-- a nice example of function composition
clamp :: Double -> Double
clamp = max 0 . min 1
 
-- uses recursion to shuffle a list, 
-- which is not the most efficient way to do it, 
-- but it's a lovely function nonetheless
-- import System.Random

-- shuffle :: [a] -> IO [a]
-- shuffle [] = return []
-- shuffle xs = do
--     i <- randomRIO (0, length xs - 1)
--     let (front,(a:back)) = splitAt i xs
--     rest <- shuffle (front ++ back)
--     return (a : rest)
    
minlistr ::  [Int] -> Int
minlistr  = foldr min maxBound

repeat' :: a -> [a]
repeat' x = xs where xs = x:xs

repeat'' :: a -> [a]
repeat'' x = x : repeat'' x