-- msort [] = []
-- msort [x] = [x]
-- msort xs = 
--       let (one, two) = split(xs) 
--            one = msort(one)
--            two = msort(two)
--      in merge one two

split :: [a] -> ([a], [a])
split myList = splitAt (((length myList) + 1) `div` 2) myList

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x <= y    = x:merge xs (y:ys)
                    | otherwise = y:merge (x:xs) ys
msort' [] = []
msort' [x] = [x]
msort' xs = merge (msort' one) (msort' two) where
 (one, two) = split xs


msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = 
      let (one, two) = split(xs) 
        in merge (msort one) (msort two) 

merge' :: Ord t => [t] -> [t] -> [t]
merge' [] [] = []
merge' x [] = x
merge' [] y = y
merge' [x] [y] | x <= y = x : [y]
              | x  > y = y : [x]
merge' (x:xs) (y:ys) | x <= y = x : merge xs (y : ys)
                    | x >  y = y : merge (x : xs) ys