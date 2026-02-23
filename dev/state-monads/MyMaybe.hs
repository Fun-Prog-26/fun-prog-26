-- import Control.Monad.State


data MyMaybe a = MyNothing | MyJust a deriving Show


mapMay :: (a -> b) -> MyMaybe a -> MyMaybe b 
mapMay _ MyNothing = MyNothing
mapMay f (MyJust x)   = MyJust (f x) 

instance Functor MyMaybe where 
   -- fmap :: (a -> b) -> MyMaybe a -> MyMaybe b 
   fmap = mapMay


instance Applicative MyMaybe where
    pure                        = MyJust
    (MyJust f) <*> (MyJust x)   = MyJust (f x)
    _          <*> _            = MyNothing
instance Monad MyMaybe where
---    (>>=) Nothing 
--    (>>=) :: MyMaybe a -> (a -> MyMaybe b) -> MyMaybe b
    MyNothing >>= _ = MyNothing 
    (MyJust x) >>= f = f x
  ----   (>>) :: m a -> m b -> m b
 --   return (MyMaybe x) =  x
-- fail :: String -> m a
sum1 :: MyMaybe Int ->  MyMaybe  Int ->  MyMaybe Int
sum1 n m = n >>= \x -> m >>= \y -> return (x + y)
sum2 :: MyMaybe Int ->  MyMaybe  Int ->  MyMaybe Int
sum2 n m= do 
        x <- n
        y <- m
        return (x+y)
    



safeHead :: [a] -> MyMaybe a
safeHead []   = MyNothing
safeHead xs   = MyJust (head xs)

safeLast :: [a] -> MyMaybe a
safeLast []   = MyNothing
safeLast xs   = MyJust (last xs)


--fmap safeHead ["asd", "wer"]
--[MyJust 'a',MyJust 'w']

-- fromMaybe :: MyMaybe Char -> Char
-- fromMaybe MyNothing = '-'
-- fromMaybe (MyJust ch ) = ch

--map fromMaybe $ fmap safeHead ["asd", "wer", []]
--"aw-"

type Name = String

data Employee = Employee { name    :: Name
                         , phone   :: String }
                deriving Show
m_name1, m_name2 :: MyMaybe Name
m_name1 = MyNothing
m_name2 = MyJust "Simon"

m_phone1, m_phone2 :: MyMaybe String
m_phone1 = MyNothing
m_phone2 = MyJust "(087)999"

ex01 = Employee <$> m_name1 <*> m_phone1
ex02 = Employee <$> m_name1 <*> m_phone2
ex03 = Employee <$> m_name2 <*> m_phone1
ex04 = Employee <$> m_name2 <*> m_phone2

square :: Num a => a -> a
square x = x^2

-- using map as before
squareList1 :: Num a => [a] -> [a]
squareList1 xs = map square xs    -- can drop xs here (eta reduction)

-- using fmap functor
squareList2:: Num a => [a] -> [a]
squareList2 xs = fmap square xs   -- can drop xs here (eta reduction)

-- using <$> renaming for fmap (note now infix)
squareList3 :: Num a => [a] -> [a]
squareList3 xs = square <$> xs




squareMaybe :: Num a => Maybe a -> Maybe a
squareMaybe x = square <$> x
 
squareMaybeList :: Num a => [Maybe a] -> [Maybe a]
squareMaybeList xs = fmap squareMaybe xs