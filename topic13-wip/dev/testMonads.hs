module Main where

import Control.Monad
-- import Test.QuickCheck.All
-- import Test.QuickCheck.Features
--import Test.QuickCheck.Checkers

-- 1
-- data Nope a =
--   NopeNotJpg deriving (Eq, Show)

-- instance Functor Nope where
--   fmap _ _ = NopeNotJpg

-- instance Applicative Nope where
--   pure = pure NopeNotJpg
--   _ <*> _ = NopeNotJpg

-- instance Monad Nope where
--   return = return NopeNotJpg
--   NopeNotJpg >>= _ = NopeNotJpg

data MyMaybe a = MyJust a | Nuttin  deriving (Eq, Show) 

instance Functor MyMaybe where
  fmap f (MyJust x) = MyJust (f x)
  fmap _ _ = Nuttin

instance Applicative MyMaybe where
  pure = MyJust  
  Nuttin <*> _ =Nuttin 
  (MyJust f) <*> something = fmap f something  

instance Monad MyMaybe where
   return  = MyJust 
   Nuttin >>= _ = Nuttin
   MyJust x >>= f = f x 

mayf :: Num a => a -> MyMaybe a
mayf x =  MyJust (x+1)

data Result a = Succeed a | Fail deriving (Eq, Show)

instance Functor Result where
  fmap f (Succeed x) = Succeed (f x)
  fmap _ _          = Fail

instance Applicative Result where 
  pure = Succeed
  Fail <*> _ = Fail
  (Succeed f) <*> something = fmap f something

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


-- call this as > MyJust 3 >>= f        should get back MyJust 4
-- instance EqProp (Nope a) where
--   (=-=) = eq

-- instance Arbitrary a => Arbitrary (Nope a) where
--   arbitrary = return NopeNotJpg


-- -- 2
-- data PhhhbbtttEither b a =
--     Left' a
--   | Right' b deriving (Eq, Show)

-- instance (Monoid b, Monoid a) => Monoid (PhhhbbtttEither b a) where
--   mempty = Left' mempty
--   mappend (Left' a) (Left' a') = Left' (mappend a a')
--   mappend (Right' b) (Right' b') = Right' (mappend b b')
--   mappend (Right' b) _ = Right' b
--   mappend _ (Right' b) = Right' b

-- instance Functor (PhhhbbtttEither a) where
--   fmap f (Left' x) = Left' $ f x
--   fmap _ (Right' x) = Right' x

-- instance Monoid a => Applicative (PhhhbbtttEither a) where
--   pure = Left'
--   Left' f <*> Left' a = Left' $ f a
--   Right' b <*> Right' b' = Right' $ mappend b b'
--   _ <*> Right' b = Right' b
--   Right' b <*> _ = Right' b

-- instance Monoid a => Monad (PhhhbbtttEither a) where
--   return = pure
--   Right' b >>= f = Right' b
--   Left' b >>= f = f b

-- instance (Arbitrary b, Arbitrary a) => Arbitrary (PhhhbbtttEither b a) where
--   arbitrary = do
--     a <- arbitrary
--     b <- arbitrary
--     oneof [return $ Left' b, return $ Right' a]

-- instance (Eq b, Eq a) => EqProp (PhhhbbtttEither b a) where
--   (=-=) = eq

-- 3
-- newtype Identity a =
--   Identity a deriving (Eq, Show)

-- instance Monoid a => Monoid (Identity a) where
--   mempty = Identity mempty
--   mappend (Identity a) (Identity a') = Identity $ mappend a a'

-- instance Functor Identity where
--   fmap f (Identity a) = Identity $ f a

-- instance Applicative Identity where
--   pure = Identity
--   Identity f <*> Identity a = Identity $ f a

-- instance Monad Identity where
--   return = pure
--   Identity a >>= f = f a

-- instance Arbitrary a => Arbitrary (Identity a) where
--   arbitrary = do
--     a <- arbitrary
--     return $ Identity a
--   -- alternatively
--   {- arbitrary =-}
--   {-   arbitrary >>=-}
--   {-     (\x -> return $ Identity x)-}

-- instance Eq a => EqProp (Identity a) where
--   (=-=) = eq

-- 4
-- data List a =
--     Nil
--   | Cons a deriving (Eq, Show)

-- instance Monoid a => Monoid (List a) where
--   mempty = Cons mempty
--   mappend Nil _ = Nil
--   mappend _ Nil = Nil
--   mappend (Cons a) (Cons a') = Cons $ mappend a a'

-- instance Functor List where
--   fmap _ Nil = Nil
--   fmap f (Cons a) = Cons $ f a

-- instance Applicative List where
--   pure = Cons
--   Nil <*> _ = Nil
--   Cons f <*> Nil = Nil
--   Cons f <*> Cons a = Cons $ f a

-- instance Monad List where
--   return = Cons
--   Nil >>= _ = Nil
--   Cons a >>= f = f a

-- instance Arbitrary a => Arbitrary (List a) where
--   arbitrary = do
--     a <- arbitrary
--     oneof [return $ Cons a, return Nil]

-- instance Eq a => EqProp (List a) where
--   (=-=) = eq

type StringTuple = (String, String, String)

main :: IO ()
main = do
  putStrLn "Nope Monad"
 -- functor $ (NopeNotJpg :: Nope StringTuple)
  -- quickBatch (applicative $ (NopeNotJpg :: Nope StringTuple))
  -- quickBatch (monad $ (NopeNotJpg :: Nope StringTuple))
  putStrLn ""

--   putStrLn "PhhhbbtttEither Monad"
--   quickBatch (monoid $ (Right' "foo" :: PhhhbbtttEither String String))
--   quickBatch (functor $ (Right' ("a", "a", "a") :: PhhhbbtttEither StringTuple StringTuple))
--   quickBatch (applicative $ (Right' ("a", "a", "a") :: PhhhbbtttEither StringTuple StringTuple))
--   quickBatch (monad $ (Right' ("a", "a", "a") :: PhhhbbtttEither StringTuple StringTuple))
--   putStrLn ""

--   putStrLn "Identity Monad"
--   quickBatch (monoid $ (Identity "foo"))
--   quickBatch (functor $ (Identity ("a", "a", "a") :: Identity StringTuple))
--   quickBatch (applicative $ (Identity ("a", "a", "a") :: Identity StringTuple))
--   quickBatch (monad $ (Identity ("a", "a", "a") :: Identity StringTuple))
--   putStrLn ""

--   putStrLn "List Monad"
--   quickBatch (monoid $ (Cons "foo"))
--   quickBatch (functor $ (Nil :: List StringTuple))
--   quickBatch (applicative $ (Nil :: List StringTuple))
--   quickBatch (monad $ (Nil :: List StringTuple))
  putStrLn ""