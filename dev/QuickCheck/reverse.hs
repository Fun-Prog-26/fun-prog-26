reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++[x]

reverseAccum :: [a] -> [a]
reverseAccum  list = revHelper [] list
     where revHelper  accum []        = accum
           revHelper  accum (x:xs)    = revHelper (x:accum) xs

reverseFold :: [a] -> [a]
reverseFold list = foldl (\acc x -> x : acc) [] list