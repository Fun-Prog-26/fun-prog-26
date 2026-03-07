sumsq :: Integral a => a -> a
sumsq n = foldr op 0 [1..n]
                 where op :: Num a => a -> a -> a
                     op x y = x*x + y