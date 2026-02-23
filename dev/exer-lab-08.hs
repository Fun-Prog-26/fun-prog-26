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

safeHead :: [a] -> MyMaybe a
safeHead []   = MyNothing
safeHead xs   = MyJust (head xs)

safeLast :: [a] -> MyMaybe a
safeLast []   = MyNothing
safeLast xs   = MyJust (last xs)

myQuestion =  [safeHead, safeLast] <*> [ "First", "Second", ""]


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
