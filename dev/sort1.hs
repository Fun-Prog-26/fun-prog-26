import Data.List (sort, sortBy)

names :: [(String, String)]
names = [("Hugo", "Keenan"),
         ("Mack", "Hansen"),
         ("James", "Lowe"),
         ("Bundee", "Aki"),
         ("Robbie", "Henshaw"),
         ("Sam", "Prendergast"),
         ("Dan", "Sheehan"),
         ("Jack ", "Crowley")  ,
         ("Caelan", "Doris")]

compareLastNames :: Ord a => (a, a) -> (a, a) -> Ordering
compareLastNames name1 name2
           | lastName1 > lastName2 = GT
           | lastName1 < lastName2 = LT
           | otherwise = EQ
    where   lastName1 = snd name1
            lastName2 = snd name2

