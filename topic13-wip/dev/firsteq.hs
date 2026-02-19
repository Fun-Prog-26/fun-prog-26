data Color = Red | Green | Blue

class IsChar a where
   fromChar :: Char -> a
   toChar :: a -> Char
instance IsChar Char  where
   fromChar = id
   toChar = id



colorEq :: Color -> Color -> Bool
colorEq Red   Red   = True
colorEq Green Green = True
colorEq Blue  Blue  = True
colorEq _     _     = False

stringEq :: [Char] -> [Char] -> Bool
stringEq []  [] = True
stringEq (x:xs) (y:ys) = toChar x == toChar y && stringEq xs ys
stringEq _ _ = False

class BasicEq a where
    isEqual :: a-> a-> Bool

instance BasicEq Bool where
    isEqual True True   = True
    isEqual False False = True
    isEqual _ _         = False

instance IsChar a => BasicEq   [ a ] where
    isEqual [] []         = True
    isEqual (x:xs) (y:ys) =  toChar x == toChar y && isEqual xs ys
    isEqual _ _           = False

instance BasicEq Color where
    isEqual Red   Red   = True
    isEqual Green Green = True
    isEqual Blue  Blue  = True
    isEqual _     _     = False

