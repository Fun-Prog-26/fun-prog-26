import System.IO  
import Control.Monad
import Debug.Trace
import Data.Time.Clock
{-# LANGUAGE MultiWayIf #-}
-- half :: Int -> Maybe Int
-- half x = if even x
--            then Just (x `div` 2)
--            else Nothing

-- getLine :: IO String
-- readFile :: FilePath -> IO String
-- putStrLn :: String -> IO ()

foo = do
    filename <- getLine
    contents <- readFile filename
    putStrLn contents

foo2 = do 
    contents <- readFile "Main.hs"
    putStrLn contents

foo3 = do     
    todoItem <- getLine  
    appendFile "todo.txt" (todoItem ++ "\n")  

foo4 = do  
        let list = []
        handle <- openFile "test.txt" ReadMode
        contents <- hGetContents handle
        let singlewords =   trace (show $ words contents) words contents 
            list = f singlewords
        print list
        hClose handle   

f :: [String] -> [Double]
f = map read


foo5 = do  
        contents <- readFile "test.txt"
        print . map readInt . words $ contents
foo6 =  print . map readInt. words =<< readFile "test.txt"

readInt :: String -> Int
readInt = read

--Writer Monad
data  Writer w a = Writer { runWriter :: (a, w) }

-- half :: Int -> Writer String Int
-- half x = do
--         tell ("I just halved " ++ show x ++ "!")
--         return (x `div` 2)

half x = (x `div` 2, "I just halved " ++ (show x) ++ "!")

whileG :: (a -> IO Bool) -> (a -> IO a) -> (a -> IO a)

whileG cond op x
  = do test <- cond x
       if test
          then do op x
                  whileG cond op x
          else return x

repeat' :: IO Bool -> IO () -> IO ()

repeat' test m
  = do res <- test
       if res 
          then return ()
          else do m
                  repeat' test m

-- testrepeat = do 
--               x<- getInt
--               repeat' ( x > 10) op 
--               where op = do 
--                   putStrLn x
--                   x<- getInt
--performs a sequence of actions and accumulates their result in a list 
accumulate :: [IO a] -> IO [a]
accumulate [] = return []
accumulate (a:as) = do 
                       x<- a                       
                       xs <- accumulate as
                       return (x:xs)


--which performs the ineractions in turn, but discards their results. 
sequence' :: [IO a] -> IO ()
sequence' [] = return ()
sequence' (a:as) = do 
                    a
                    sequence' as
                    return()


--sequence a series, passing values from one to the next
-- seqLists :: [a-> IO a]  -> a -> IO a
-- seqLists = undefined



m::Show a => a -> IO ()
m = putStrLn . show

testf :: String -> IO String
testf x =  do
           putStrLn x
           return (x ++ x)

seqList ::  [a-> IO a]  -> a -> IO a 
seqList [] elem = return elem

seqList (a:as) elem = do
                       x <- a elem
                       seqList as x
                       
copyInteract :: IO ()
copyInteract = do    
                 hSetBuffering stdin LineBuffering
                 copyEOF
                 hSetBuffering stdin NoBuffering

copyEOF :: IO ()
copyEOF = do 
            eof <- isEOF
            if eof 
              then return ()
              else do line <- getLine
                      putStrLn line
                      copyEOF

trans :: String -> String 
trans "hello" = "goodbye"
trans "cat"   = "dog"  
trans "sat"   = "stood"
trans _       = "undefined"    
respondPalindromes :: String -> String
respondPalindromes = unlines . map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") . lines  
    where   isPalindrome xs = xs == reverse xs  
listIOprog :: String -> String
listIOprog = unlines . map reverse . lines
-- main = interact trans 


addOneInt :: IO()
addOneInt = do 
             line <- getLine
             putStrLn( show (1 + read line ::Int))

addOneInt' :: IO()
addOneInt' = getLine >>= \line -> putStrLn (show(1 + read line ::Int))

getInt :: IO Integer
getInt = do 
          line <- getLine
          return (read line :: Integer)

sumIntsdo :: Integer -> IO Integer
sumIntsdo s = do 
               n <- getInt
               if n == 0 
                then return s
                else sumIntsdo (s + n)

sumIntsMonad :: Integer -> IO Integer
sumIntsMonad s = getInt >>= \n ->  if n ==0 then return s else sumIntsMonad (s+n)
-- case (n==0)  of
--                                      True -> return s 
--                                      False ->  sumIntsMonad (s+n)

--                                     \k -> if
--   | k < 0     -> "negative"
--   | k == 0    -> "zero"
--   | otherwise -> "positive"
-- \y (z:zs) -> if (p y) then y:(z:zs) else (z:zs))

readWrite :: IO ()
readWrite = 
        do line <- getLine
           putStrLn line

-- readWriteMonad :: IO ()
-- readWriteMonad = getLine >>= \line -> putStrLn line

main = putStrLn "Hello World"