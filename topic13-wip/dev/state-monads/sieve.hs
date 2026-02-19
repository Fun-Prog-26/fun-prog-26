sieve (p:xs) =     [x | x <- xs, x `mod` p /= 0 ]

primes :: [Int]
primes = map head (iterate sieve [2..])

myprimes = takeWhile (<1000) primes

repeat'::a ->  [a]
repeat' x = x: repeat' x 

cycle'::[a] ->  [a] 
cycle' xs =xs ++ cycle' xs


headFile' f = do
     c <- readFile f
     let c' = unlines. take 5. lines $c
     putStrLn c'
