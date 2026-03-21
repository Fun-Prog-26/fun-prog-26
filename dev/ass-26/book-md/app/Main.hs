module Main (main) where

import Catalogue ( parseCatalogue )


main :: IO ()
main = do
  input <- readFile "books.xml"
  print (parseCatalogue input)