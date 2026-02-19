-- Instead of solving this as a single function, worth thinking about how you can 
-- decompose the problem: write a function to get an integer, and another
-- to do the summing.

-- Useful auxiliary function, taking the prompt as parameter.

getInteger :: String -> IO Integer

getInteger prompt
  = do putStr prompt
       st <- getLine
       return (read st :: Integer)

-- Sum N integers: prompt, number to sum and and "sum so far" are the parameters

sumNints :: String -> Integer -> Integer -> IO Integer

sumNints prompt n s
  = if n<=0 
       then return s
       else do m <- getInteger prompt
               sumNints prompt (n-1) (s+m)

prodNints :: String -> Integer -> Integer -> IO Integer

prodNints prompt n s
  = if n<=0 
       then return s
       else do m <- getInteger prompt
               prodNints prompt (n-1) (s*m)
--- The function itself

getNints :: IO ()

getNints
  = do boundP <- getInteger "Input the number of integers to multiply together: "
       prod <- prodNints "Input an integer to multiply" boundP 1
       putStrLn ("The product of these integers is "++ show prod)


--        getNints :: IO ()

-- -- getNints
--   = do bound <- getInteger "Input the number of integers to add together: "
--        sum <- sumNints "Input an integer: " bound 0
--        boundP <- getInteger "Input the number of integers to multiply together: "
--        prod <- prodNints "Input an integer to multiply" boundP 1
--        putStrLn ("The sum of these integers is "++ show prod)