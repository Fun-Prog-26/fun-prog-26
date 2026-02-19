ifEvenInc :: Integral a => a -> a   -- could be Int-> Int but better to be general
ifEvenInc n =
  if even n
    then n + 1
    else n

ifEvenDouble :: Integral a => a -> a 
ifEvenDouble n =
  if even n
    then n * 2
    else n

ifEvenSquare :: Integral a => a -> a 
ifEvenSquare n =
  if even n
    then n ^ 2
    else n

inc :: Num a => a -> a
inc n = n + 1

double :: Num a => a -> a
double n = n * 2

square :: Num a => a -> a
square n = n ^ 2

ifEven :: Integral a => (a -> a) -> a -> a
ifEven f n =
  if even n
    then f n
    else n

genIfEven :: Integral a => (a -> a) -> a -> a
genIfEven f = (\x ->  ifEven f x)

add4 :: Num n => n -> n -> n -> n -> n
add4  a b c d = a + b + c + d

addXto3 :: Num n => n -> n -> n -> n -> n
addXto3 x = (\b c d -> add4 x b c d)

addXYto2 :: Num n => n -> n -> n -> n -> n
addXYto2 x y = (\c d -> add4 x y c d)

mystery  = add4 3

anotherMystery = add4 3 4 