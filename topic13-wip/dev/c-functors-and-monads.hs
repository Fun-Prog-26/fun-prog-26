module Main where

import Control.Monad
import System.IO 

--Exercise 1
fmap :: (a -> b) -> IO a -> IO b

fmap f m
  = do x <- m
       return (f x)
--Exercise 2
repeat' :: IO Bool -> IO () -> IO ()

repeat' test m
  = do res <- test
       if res 
          then return ()
          else do m
                  repeat' test m
--Exercise 3
whileG :: (a -> IO Bool) -> (a -> IO a) -> (a -> IO a)

whileG cond op x
  = do test <- cond x
       if test
          then do op x
                  whileG cond op x
          else return x
--Exercise 4

findAvg :: IO Integer

findAvg 
  = do n <- getInt
       s <- sumInts n 0
       return (s `div` n)

sumInts :: Integer -> Integer -> IO Integer

sumInts n s 
  = if n>0 
       then do m <- getInt
               sumInts (n-1) (s+m)
       else return s     
--Exercise 5
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
                       
--Exercises in c-functors-and-monads.tex 
--Exercise 5
getInt :: IO Integer
getInt = do line <- getLine
            return (read line :: Integer)


sumAcc :: Int -> [Int] -> Int
sumAcc s [] = s
sumAcc s (n:ns) = if n == 0
                     then s
                     else sumAcc (s + n) ns

sumInteract :: IO ()
sumInteract = 
   do putStrLn "Enter integers one per line"
      putStrLn "These will be summed until 0 is entered"
      sum <- sumInts 0
      putStr "The sum is "
      print sum



--in lectures
data MyMaybe a = MyJust a | Nuttin  deriving (Eq, Show) 

instance Functor MyMaybe where
  fmap' f (MyJust x) = MyJust (f x)
  fmap' _ _ = Nuttin

instance Applicative MyMaybe where
  pure = MyJust  
  Nuttin <*> _ =Nuttin 
  (MyJust f) <*> something = fmap' f something  

instance Monad MyMaybe where
   return  = MyJust 
   Nuttin >>= _ = Nuttin
   MyJust x >>= f = f x 

mayf :: Num a => a -> MyMaybe a
mayf x =  MyJust (x+1)


-- call this as > MyJust 3 >>= mayf        should get back MyJust 4

data Result a = Succeed a | Fail deriving (Eq, Show)
--Exercise 6

instance Functor Result where
  fmap'' f (Succeed x) = Succeed (f x)
  fmap'' _ _          = Fail

instance Applicative Result where 
  pure = Succeed
  Fail <*> _ = Fail
  (Succeed f) <*> something = fmap'' f something

instance Monad Result where
  return = Succeed
  Succeed x >>= f = f x
  Fail >>= _ = Fail

divBy :: Int -> Int -> Result Int
divBy 0 _ = Fail
divBy x y = Succeed ( y `div`x)

--Succeed 40 >>= divBy 0   -- Fail
--Fail >>= divBy 4  -- Fail
--Succeed 40 >>= divBy 5  - Succeed 8


