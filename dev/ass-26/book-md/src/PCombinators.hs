module PCombinators where

import ADTs  
import Parser

charP :: Char -> Parser Char
charP c = Parser $ \input ->
  case input of
    (x:xs) | x == c -> Right (xs, x)
    _ -> Left ("Expected " ++ [c])

stringP :: String -> Parser String
stringP = traverse charP

spanP :: (Char -> Bool) -> Parser String
spanP p = Parser $ \input ->
  let (match, rest) = span p input
  in Right (rest, match)

ws :: Parser String
ws = spanP (`elem` " \n\t")