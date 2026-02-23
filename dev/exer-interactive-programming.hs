palindrome::  IO ()
palindrome = do word <- getLine
                if word == reverse word then
                   putStrLn("palindrome")
                else 
                   putStrLn("not a palindrome")
interactiveIntSum
  = do putStr "Input an integer (followed by Return): "
       st1 <- getLine
       let int1 = read st1 :: Int
       putStr "Input another integer (followed by Return): "
       st2 <- getLine
       let int2 = read st2 :: Int
       putStrLn ("The sum of these integers is "++ show (int1+int2))
summingUp :: IO ()
summingUp = do num1 <- getLine
               num2 <- getLine
               let sum =  read num1 + read num2
               putStrLn  (" Their sum is "  ++ show (sum))

putNTimes :: Integer -> String -> IO ()
putNTimes 0 str  = return ()
putNTimes n str  = do putStr str
                      putNTimes (n-1) str


getInteger :: String -> IO Integer
getInteger prompt = do putStr prompt
                       st1 <- getLine                     
                       return (read st1 :: Integer)

sumNInts :: Integer -> Integer -> IO Integer

sumNInts  n  sum   = if n<= 0 then 
                        return sum  else
                        do x <- getInteger "Enter next number"
                           sumNInts (n-1) (sum + x)
                       