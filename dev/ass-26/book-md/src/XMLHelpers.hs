module
    XMLHelpers
     where

import ADTs
import PCombinators
import Parser


openTag :: String -> Parser String
openTag name = do
  ws
  stringP "<"
  stringP name
  stringP ">"

closeTag :: String -> Parser String
closeTag name = do
  ws
  stringP "</"
  stringP name
  stringP ">"

element :: String -> Parser a -> Parser a
element name inner = do
  openTag name
  ws
  val <- inner
  ws
  closeTag name
  return val

textP :: Parser String
textP = do
  ws
  txt <- spanP (/= '<')
  return (trim txt)

trim :: String -> String
trim = f . f
  where f = reverse . dropWhile (`elem` " \n\t")

authorP :: Parser Author
authorP = element "author" $ do
  aid  <- element "id" textP
  name <- element "name" textP
  return (Author aid name)

authorsP :: Parser [Author]
authorsP =
  element "authors" (many authorP)

many :: Parser a -> Parser [a]
many p = Parser $ \input ->
  case runParser p input of
    Left _ -> Right (input, [])   -- 🔥 do NOT consume anything
    Right (rest, x) ->
      case runParser (many p) rest of
        Left err -> Left err
        Right (rest', xs) -> Right (rest', x:xs)

some :: Parser a -> Parser [a]
some p = do
  x <- p
  xs <- many p
  return (x:xs)

publishedP :: Parser Int
publishedP = do
  attrs <- selfClosingTag "published"
  case lookup "year" attrs of
    Just y  -> return (read y)
    Nothing -> Parser $ \_ -> Left "Missing year attribute"

titleP :: Parser String
titleP = element "title" textP

subtitleP :: Parser (Maybe String)
subtitleP =
  (Just <$> element "subtitle" textP)
  `orElse` pure Nothing

selfClosingTag :: String -> Parser [(String, String)]
selfClosingTag name = do
  stringP "<"
  stringP name
  attrs <- many attributePair
  stringP "/>"
  return attrs

attributePair :: Parser (String, String)
attributePair = do
  stringP " "
  key <- spanP (/= '=')
  stringP "=\""
  val <- spanP (/= '"')
  stringP "\""
  return (key, val)

bookP :: Parser Book
bookP = element "book" $ do
  i  <- element "isbn" textP
  ws
  t  <- element "title" textP
  ws
  s <- subtitleP
  ws
  as <- authorsP
  ws
  y  <- publishedP
  return (Book i t s as y)
