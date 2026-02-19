-- function application and composition
-- . Write bigCubes that takes a list and returns a
-- list of cubes that are > 500

cube :: Int -> Int
cube x = x^3

bigcubes :: [Int] -> [Int]
bigcubes xs = filter (<200) $ map (^3) xs

-- Write lottaBiggest that takes a list and replicates
-- the largest element 4 times. lottaBiggest [2,5,3,1]
-- => [5,5,5,5]

lottaBiggest :: [Int] -> [Int]
lottaBiggest xs = replicate  4 $  maximum  xs

-- Write powers that takes a number and creates a
-- list of that number squared, cubed, and
-- quadrupled. powers 2 => [4,8,16]

powers :: Int -> [Int]
powers x = zipWith ($) [(^2), (^3), (*5) ] $ replicate 3 x

