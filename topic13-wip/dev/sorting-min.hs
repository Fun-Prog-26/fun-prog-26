module ComparingSortingGrouping  where
-- From Tim Sheard
import Data.List(sort,sortBy,group,groupBy)

data Category =  Blue | Green | Orange 
  deriving (Eq,Ord,Show)

people = 
  [("Tim",24,Blue,"Waterford")
  ,("Tom",36,Blue,"Tipperary")
  ,("Mary",19,Orange,"Dublin")
  ,("Zach",41,Blue,"Tipperary")
  ,("Ann",9,Green,"Wexford")
  ]

name   (nm,ag,cat,st) = nm  
age   (nm,ag,cat,st)  =  ag
category (nm,ag,cat,st)  = cat  
county (nm,ag,cat,st)  = st  

------------------------------------
-- the names of all people who live in Waterford

p1 = sort [name p | p <- people, county p == "Waterford"]
-------------------------------------------
-- How many people live in Tipperary

p2 = length  [name p | p <- people, county p == "Tipperary"] 


-------------------------------------------------
-- the list of ages of people who live in Cork

p3 = undefined

----------------------------------------------
-- The names of all people in the survey
-- in alphabetical order

p4 = undefined

----------------------------------------------------
-- The names and category of all people, sorted by category

p5:: [(String,Category)]
p5 = undefined
--------------------------------------------------------
-- The category and the count of all those with that category

p6:: [(Category,Int)]
p6 =  undefined

-----------------------------------------------------
-- The category and a list of all names with that category

p7:: [(Category,[String])]
p7 = undefined


----------------------------------------------
-- The names and ages of all those who live in Waterford
-- grouped by age.

p8:: [[(String,Integer)]]
p8 = undefined
