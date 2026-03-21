module Catalogue where

import XMLHelpers 
import ADTs
import Parser

catalogueP :: Parser Catalogue
catalogueP =
  element "catalogue" (Catalogue <$> many bookP)

parseCatalogue :: String -> Either String Catalogue
parseCatalogue input =
  case runParser catalogueP input of
    Left err -> Left err
    Right (_, result) -> Right result