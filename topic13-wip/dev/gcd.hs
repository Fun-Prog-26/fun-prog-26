import Control.Monad.Writer

gcd' :: Integer -> Integer -> Integer
gcd' a 0 = a
gcd' a b = gcd b (a `mod` b)

gcdCountSteps :: Integer -> Integer -> Writer (Sum Int) Integer
gcdCountSteps a 0 = tell (Sum 1) >> pure a
gcdCountSteps a b = tell (Sum 1) >> gcdCountSteps b (a `mod` b)

gcdLogSteps :: Integer -> Integer -> Writer [(Integer, Integer)] Integer
gcdLogSteps a 0 = tell [(a,0)] >> pure a
gcdLogSteps a b = tell [(a,b)] >> gcdLogSteps b (a `mod` b)

gcdLogSteps' a b = mapWriter mapper (gcdLogSteps a b)
  where
    mapper (a, w) = (a, Sum $ length w)

gcdLogSteps'' = (mapWriter (Sum . length <$>) .) . gcdLogSteps

main = print "OK"
