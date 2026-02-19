
module Validation where

import  qualified Data.Text  as T (pack, unpack, length, strip)
import Data.Either (Either)
isValid :: String -> Either String String
isValid s = if length (filter (/=' ') s) < 300 && T.strip (T.pack s) == T.pack s then Right s else Left "invalid input, must be less than 300 characters"
