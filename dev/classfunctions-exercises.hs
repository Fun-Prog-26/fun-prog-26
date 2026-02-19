--Functions - Exercises
halve :: [a] -> ([a], [a]) 
halve xs = (take half xs, drop half xs) where 
       half = length xs `div` 2

third :: [a] -> a
third xs = head (tail (tail xs)) 

f :: [a] -> a
f xs = xs !! 3

third'' :: [a] -> a
third'' (_:_:x:_) = x

safetail :: [a] -> [a]
safetail xs   =  if  null xs   then  [] else  tail xs

safetail' :: [a] -> [a]
safetail' xs | null xs  = []
             | otherwise = tail xs

safetail'' ::[a] -> [a]
safetail'' [] = []
safetail'' (_:xs) = xs

myor:: Bool -> Bool -> Bool
False  `myor` False = False
_ `myor` _          = True

myor':: Bool -> Bool -> Bool
False  `myor'` b = b
True `myor'` _   = True

-- (from Learn you a good Haskell)
lucky :: Integral a =>  a-> String
lucky 7 = "Lucky you.. Proceed directly to buy a lottery ticket."
lucky 13 = "You, sadly are quite unlucky. Do not, under any circumstances, invest money today "
lucky _ = "Mmmm.... Can't really say...."

fst':: (a,b,c) -> a
fst'(x, _, _) = x
snd' :: (a,b,c) -> b
snd'(_, y,_) = y
thrd' :: (a,b,c) -> c
thrd'(_, _,z) = z

luhnDouble :: Int -> Int
luhnDouble d = if n>9 then n-9 else n
      where n = d*2
altMap f g [] = []
altMap f g (x:xs) = f x : altMap g f xs

check :: Int -> Bool 
check n = n `mod` 10 == 0
luhn' :: [Int] -> Bool 
luhn' = check . sum . altMap id luhnDouble . reverse
luhn :: Int -> Int -> Int -> Int -> Bool
luhn a b c d = (a' + b + c'+ d ) `mod` 10 == 0 where
       a' = luhnDouble a
       c' = luhnDouble c

luhnGetCheck :: Int-> Int -> Int -> Int
luhnGetCheck a b c = (10 - (luhnSum `mod` 10)) `mod` 10   where  -- seccond `mod` to check for 10
       luhnSum = luhnDouble a + b + luhnDouble c 

patterns :: Eq a => a -> [a] -> [Int]
patterns  x xs = [i | (x', i) <- zip xs [1..], x ==x']

matches :: Eq a => a -> [a] -> [a]
matches x xs = [x' | x'<- xs, x == x']

--using matches
myElem :: Eq a => a -> [a] -> Bool
myElem x xs = matches x xs /=[]

--using patterns
myElem' :: Eq a => a -> [a] -> Bool
myElem' x xs = patterns x xs /=[]