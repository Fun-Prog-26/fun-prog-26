-- Lab test for Haskell. This is worth 5% of your overall score. This test is worth 100 Marks. 
-- This file is made up of 
-- 		SECTION A - 30 Marks
-- 		SECTION B - 30 Marks
-- 		SECTION C - 40 Marks  (this is in clas_test_fixing errors.hs) )

-- Please put your name below (where indicated) and zip the files into a .zip file using the naming convention 
-- first letter of first name + last name (e.g. mmeagher.zip)


-- PLEASE FILL THIS IN
-- Student Name : Davin Barron

--SECTION A - 30 Marks

--  In this section replace each "X2 = undefined" with "X2 = fully-parenthesiszed-expression"

-- such that X1 and X2 evaluate to the same value.
-- You may want to consult the table of precedences (see Lab-03)

--- For example I have done "a2" below

a1 = 10 - 4 / 2
a2 = (10 - (4 / 2))


------------------------------
b1 = 8 > 3 + 2
b2 = 8 > (3 + 2)

------------------------------
c1 = length [1,2,3] * 2 + 5
c2 = (length [1,2,3]) * 2 + 5

-----------------------------
d1 = 6 ^ id 2
d2 = 6 ^ (id 2)

-----------------------------
e1 = [1,2,3,4] !! 1 + 3
e2 = ([1,2,3,4] !! 1) + 3

-----------------------------
f1 = False || 5 == 10 `div` 2
f2 = False || (5 == (10 `div` 2))

------------------------------
g1 = not False && 4 `elem` [2,4,6]
g2 = (not False) && (4 `elem` [2,4,6])


---------------------------------------------------------------------
-- if when you type "checkAll" you get True, then you have succeeded  with all parts of this section. 

checkAll = all (==True) [a1==a2, b1==b2,c1==c2,d1==d2,e1==e2,f1==f2,g1==g2]



--SECTION B - 30 Marks
-- For each named expression replace "undefined"
-- with an expression with the same type as the declaration


j1:: (Bool, Double)
j1 = (True, 10.0)

j2:: [Char]
j2 = ['a', 'b', 'c']

j3:: (Int, [String])
j3 = (3, ["Hello", "Everyone"])

j4:: (Float, Bool)
j4 = (7.0, True)

j5:: ([Int], Either String Char)
j5 = ([1, 2, 3], Left "Hello")

j6:: (String, (Int, [Bool]))
j6 = ("Hello", (5, [True, False]))

j7:: [[[Char]]]
j7 =  [[['a', 'b'], ['c', 'd']], [['e', 'f'], ['g', 'h']]]

j8:: [(Double, [Int])]
j8 = [(10.0, [1,2,3]), (12.0, [4,5,6])]