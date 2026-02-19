import Data.Int (Int)
-- For full instructions see the other file (class_test.hs)
-- PLEASE FILL THIS IN
-- Student Name : graham heeney


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

a1:: Integer
a1 = 89                   


a2 = 7 * 6             


a3 = [99]                    


a4 = length [4]         

a5:: String
a5 = if a3 == [99] then "one" else "0"     


a6:: Int -> Int
a6 x = x `div` 2


a7 = "ten"


a8 = (a6, a7)

a9:: Bool
a9 = False && True


a10:: [Int] -> Int
a10 x = length x + 5 
