module Parser where
    
type Error = String

type Result a = Either Error (String, a)

newtype Parser a = Parser { runParser :: String -> Result a }

instance Functor Parser where
  fmap f (Parser p) = Parser $ \input ->
    case p input of
      Left err -> Left err
      Right (rest, a) -> Right (rest, f a)

instance Applicative Parser where
  pure a = Parser $ \input -> Right (input, a)

  Parser pf <*> Parser pa = Parser $ \input ->
    case pf input of
      Left err -> Left err
      Right (rest, f) ->
        case pa rest of
          Left err -> Left err
          Right (rest', a) -> Right (rest', f a)

instance Monad Parser where
  Parser pa >>= f = Parser $ \input ->
    case pa input of
      Left err -> Left err
      Right (rest, a) -> runParser (f a) rest


orElse :: Parser a -> Parser a -> Parser a
orElse (Parser p1) (Parser p2) = Parser $ \input ->
  case p1 input of
    Left _ -> p2 input
    res    -> res