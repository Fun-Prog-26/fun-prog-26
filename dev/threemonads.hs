import Data.Monoid
import Control.Applicative -- Otherwise you can't do the Applicative instance.
import Control.Monad 
import Control.Monad.Writer

--three monads lyah
-- isBigGang :: Int -> (Bool, String)
-- isBigGang x = (x > 9, "Compared gang size to 9.")

-- applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
-- applyLog (x, log) f = let (y, newLog) = f x in (y, log ++ " "++ newLog)

-- --aLog :: (a, [c]) -> (a -> (b, [c])) -> (b, [c])

-- aLog :: Monoid m => (a, m) -> (a -> (b, m)) -> (b,m)
-- aLog (x, log) f = let (y,newLog) = f x in (y, log `mappend` newLog)

-- type Food = String
-- type Price = Sum Int
-- addDrink :: Food -> (Food, Price)
-- addDrink "beans" = ("milk", Sum 25)
-- addDrink "jerky" = ("whiskey", Sum 99)
-- addDrink _ = ("beer", Sum 30)

-- newtype Writer w a = Writer {runWriter :: (a,w) }

-- instance  (Monoid w ) => Functor  (Writer w) where
--     fmap = liftM
  
-- instance (Monoid w ) => Applicative (Writer w) where
--     pure  = return
--     (<*>) = ap

-- instance (Monoid w) => Monad (Writer w) where
--     return x = Writer (x, mempty)
--     (Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')

-- logNumber :: Int -> Writer [String] Int
-- logNumber x = Writer (x, ["Got number: " ++ show x])

-- multWithLog :: Writer [String] Int
-- multWithLog = do
--     a <- logNumber 3
--     b <- logNumber 5
--     return (a*b)
--    -- import Control.Monad.Writer
gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0 = do
      tell ["Finished with " ++ show a]
      return a
    |otherwise = do
      tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
      gcd' b (a `mod` b)