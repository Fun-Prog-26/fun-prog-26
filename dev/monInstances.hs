module MonInstances where

import Data.List (sort, sortBy, group, groupBy)

data Province = Munster | Leinster | Connacht
  deriving (Eq, Ord, Show)

people :: [(String, Integer, Province, String)]
people =
  [ ("Tim", 24, Munster, "Waterford")
  , ("Tom", 36, Munster, "Tipperary")
  , ("Mary", 19, Connacht, "Galway")
  , ("Zach", 41, Munster, "Tipperary")
  , ("Ann", 9, Leinster, "Wexford")
  ]

name :: (String, Integer, Province, String) -> String
name (nm, _, _, _) = nm

age :: (String, Integer, Province, String) -> Integer
age (_, ag, _, _) = ag

province :: (String, Integer, Province, String) -> Province
province (_, _, cat, _) = cat

county :: (String, Integer, Province, String) -> String
county (_, _, _, st) = st

galwayPeople :: [String]
galwayPeople = sort [name p | p <- people, county p == "Galway"]

tippPeopleAge :: [[(String, Integer)]]
tippPeopleAge = group (sortBy (\(_, a1) (_, a2) -> compare a1 a2) [(name p, age p) | p <- people, county p == "Tipperary"])

catCount :: [(Province, Int)]
catCount = [(head xs, length xs) | xs <- group (sort [province p | p <- people])]


data Expr = Val Int | Mult Expr Expr deriving Show
type Cont = [Op]
data Op = EVAL Expr | MULT Int

eval :: Expr -> Cont -> Int
eval (Val n)   c = exec c n
eval (Mult x y) c = eval x (EVAL y : c)

exec :: Cont -> Int -> Int
exec          []           n = n
exec (EVAL y : c) n = eval y (MULT n : c)
exec (MULT n : c)  m = exec c (n*m)

value :: Expr -> Int
value e = eval e []
