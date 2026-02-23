import Control.Monad 
import System.IO 

data Expr = Val Int | Div Expr Expr | Mul Expr Expr | Max Expr Expr

safediv :: Int -> Int -> Maybe Int
safediv n m = if m==0 then 
                  Nothing
              else Just (n `div` m)



eval :: Expr  -> Maybe Int
eval (Val n) = Just n
eval (Div x y) = case eval x of 
                  Nothing -> Nothing  
                  Just n -> case eval y of 
                      Nothing -> Nothing
                      Just m -> safediv n m
eval (Mul x y) = do 
                    n <- eval x
                    m <- eval y
                    return ( n * m)
eval (Max x y ) = do 
                    n <- eval x
                    m <- eval y
                    if n > m  then return n else return m 
eval2 :: Expr -> Maybe Int
eval2 (Val n) = return n
eval2 (Div x y) = eval x >>= \n -> 
                    eval y >>= \m -> 
                    safediv n m 

eval3 :: Expr -> Maybe Int
eval3 (Val n) = return n
eval3 (Div x y) = do
                    n <- eval x
                    m <- eval y
                    safediv n m
eval3 (Mul x y) = do 
                    n <- eval x
                    m <- eval y
                    return ( n * m)