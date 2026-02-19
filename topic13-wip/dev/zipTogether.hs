

zipTogether :: [a] -> [b] -> [(a,b)]
zipTogether  [] [] = []
zipTogether  [] _ = []
zipTogether   _ [] = []
zipTogether (x:xs) (y:ys) = (x, y) : (zipTogether (xs)  (ys) )

--cipher 
cipher :: [Char] -> Int -> [Char]
cipher [] n = []
cipher (x:xs) n = (toEnum (fromEnum x  + n)) : cipher xs n

--makePairs
makePairs :: [a] -> [(a,a)]
makePairs [] = []
makePairs xs = zip xs (tail xs)

--isPairSorted
isPairSorted :: Ord a => [(a,a)] -> Bool
isPairSorted [] = True
isPairSorted (x:xs)  =  if (fst(x) < snd(x) ) then (isPairSorted  xs) else False

--isSorted
isSorted :: Ord a => [a] -> Bool
isSorted xs = isPairSorted (makePairs(xs))

myConcate :: [a] -> [a] -> [a]
myConcate [] yss = yss
myConcate xss [] = xss
myConcate [xx] yss = xx:yss
myConcate (xx:xss) (yss) = xx : myConcate(xss) (yss)