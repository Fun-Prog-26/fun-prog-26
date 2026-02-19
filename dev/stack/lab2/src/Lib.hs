module Utils
  where

import Data.Text 

max30Chars :: String -> Bool
max30Chars str = ( T.length xs <= 30) where
    xs = T.pack str 
