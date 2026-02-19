-- For full instructions see the other file (class_test.hs)
-- PLEASE FILL THIS IN
-- Student Name : Chris Kelleher


-- SECTION C (Worth 40 Marks) 
-- Fix the error in the file below. Load the file, read the error message
-- and fix ONE ERROR at a time. In each case, you should have the type declaration 
-- as well as the value. (Hint: Comment out the code you haven't 
-- dealt with yet.) Then load the file and read the next error
-- message. 

-- e.g. 
-- a0 = head 56
-- would be correctly written as 
-- a0 :: Int
-- a0 = head [56,45]
-- there may be many ways to make this compile - write the solution closest to the 
-- original, incorrect one. 

a1 :: Integer
a1 = 34

a2 :: String
a2 = "seven * 6"

a3 :: [Bool]
a3 = [99 == 99, True]

a4 :: Int
a4 = length [4.5]

a5 :: String
a5 = if a3 == [True, True] then "one" else "0"

a6 :: Bool -> Int
a6 x = if x then 4 else 2

a7 :: String
a7 = "ten"

a8 :: Int
a8 = a6 True

a9 :: Bool
a9 = (4 == 4) && True

a10 :: [Int] -> Bool
a10 x = length x + 5 > 9