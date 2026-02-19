-- For full instructions see the other file (class_test.hs)
-- PLEASE FILL THIS IN
-- Student Name : Paul Fitzgerald


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

-- changed a1's type to Bool
a1:: Bool
a1 = False

-- changed string "seven" to 7
a2:: Int
a2 = 7 * 6             

-- changed True to 1, as lists can only have one type
a3::[Int]
a3 = [99, 1]

-- Alternatively, this could work (a5 would have to be changed if this solution
-- was used, as Either Int Bool is not equal to type Int, as we don't know
-- whether an Int or Bool is being compared to a Bool)
alt3:: [Either Int Bool]
alt3 = [Left 99, Right True]

-- Changed 4.5 to [4.5], as length works on [Int], not Int
a4:: Int
a4 = length [4.5]          

-- Changed (a3 == 9) to (head a3) == 9, as a3 is a list
-- Also changed "one" to 1, so a5's if statement always returns an Int
-- a5:: Int
-- a5 = if (head a3) == 99 then 1 else 0 

-- Changed the input type of the function to Int, as Bool cannot be divided by
-- 2
a6:: Int -> Int
a6 x = x `div` 2

-- Changed "ten" to 10 so a8 will compile
a7:: Int
a7 = 10

a8:: Int
a8 = a6 a7

-- Changed both sides of a9's condition to Bool, as && only takes Bool
a9:: Bool
a9 = (4 /= 0) && True

-- Changed a10's type to Int -> Int to reflect the function implementation
a10:: Int -> Int
a10 x = x + 5

-- Alternatively for a10
alt10:: [Int] -> Bool
alt10 xs = (sum xs) > 5

