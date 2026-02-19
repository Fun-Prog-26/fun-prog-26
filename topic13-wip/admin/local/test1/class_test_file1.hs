-- Lab test for Haskell. This is worth 5% of your overall score. This test is worth 100 Marks. 
-- This file is made up of 
-- 		SECTION A - 30 Marks
-- 		SECTION B - 30 Marks
-- 		SECTION C - 40 Marks  (this is in clas_test_fixing errors.hs) )

-- Please put your name below (where indicated) and zip the files into a .zip file using the naming convention 
-- first letter of first name + last name (e.g. mmeagher.zip)


-- PLEASE FILL THIS IN
-- Student Name : 

--SECTION A - 30 Marks

--  In this section replace each "X2 = undefined" with "X2 = fully-parenthesiszed-expression"

-- such that X1 and X2 evaluate to the same value.
-- You may want to consult the table of precedences (see Lab-03)

--- For example I have done "a2" below

a1 = 10 - 4 / 2
a2 = (10 - (4 / 2))


------------------------------
b1 = 8 > 3 + 2
b2 = undefined

------------------------------
c1 = length [1,2,3] * 2 + 5
c2 = undefined

-----------------------------
d1 = 6 ^ id 2
d2 = undefined

-----------------------------
e1 = [1,2,3,4] !! 1 + 3
e2 = undefined

-----------------------------
f1 = False || 5 == 10 `div` 2
f2 = undefined

------------------------------
g1 = not False && 4 `elem` [2,4,6]
g2 = undefined


---------------------------------------------------------------------
-- if when you type "checkAll" you get True, then you have succeeded  with all parts of this section. 

checkAll = all (==True) [a1==a2, b1==b2,c1==c2,d1==d2,e1==e2,f1==f2,g1==g2]



--SECTION B - 30 Marks
-- For each named expression replace "undefined"
-- with an expression with the same type as the declaration


j1:: (Bool, Double)
j1 = undefined

j2:: [Char]
j2 = undefined

j3:: (Int, [String])
j3 = undefined

j4:: (Float, Maybe Bool)
j4 = undefined

j5:: ([Int], Either String Char)
j5 = undefined

j6:: (String, (Int, [Bool]))
j6 = undefined

j7:: [[[Char]]]
j7 = undefined

j8:: [(Double, [Int])]
j8 = undefined
