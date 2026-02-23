module Main where

main = do
  putStrLn "Why did the banker leave his job?"
  answer <- getLine
  putStrLn (if answer == "he lost interest"
            then "Correct!"
            else "Wrong!")
           


-- main = interact countChars

-- countChars :: String -> String
-- countChars str =
--     let allLines = lines str
--         lengths  = map (show.length) allLines
--     in unlines lengths

act :: IO (Char,Char)
act = do x <- getChar
         getChar
         y <-getChar
         putStr (show x)
         return (x,y)



getLine2 :: IO String
getLine2 = do x <- getChar
              if x == '\n' then
                 return []
              else
                 do xs <- getLine2
                    return (x:xs)

myputStr :: String -> IO ()
myputStr []     = return ()
myputStr (x:xs) = do putChar x
                     myputStr xs
put4times :: String -> IO ()
put4times str = do  
                    let x = str ++ "\n"
                    putStr (str ++"\n")    
                    putStr x
                    putStr x
                    putStr x
read2lines :: IO ()
read2lines  = do getLine
                 getLine
                 putStrLn "two lines read"

reverse2lines :: IO ()
reverse2lines = 
            do  putStrLn ("enter a string")
                line1 <- getLine
                line2  <- getLine
                putStrLn ("We're just going to reverse them now:")
                putStrLn(reverse line1)
                putStrLn(reverse line2)

strlen :: IO ()
strlen = do putStr "Enter a string: "
            xs <-  getLine
            putStr "The string has "
            putStr (show (length xs))
            putStrLn " characters"


-- add :: IO ()
add = do putStrLn "Enter two numbers"
         numstr1 <- getLine
         numstr2 <- getLine 
         let num1 = read numstr1 :: Int
         let num2 = read numstr2 :: Int
         putStrLn ("Sum is " ++ show (num1 + num2))

