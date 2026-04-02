module Main where

import Control.Applicative (Alternative (..))
import Data.Char           (isAlpha, isAlphaNum, isDigit, isSpace)

-- ─────────────────────────────────────────────────────────────────────────────
-- Core types  (exactly as in the exam question)
-- ─────────────────────────────────────────────────────────────────────────────

type Error    = String
type Result a = Either Error (String, a)

-- | A parser is a function wrapped in a newtype.
--   'runParser' unwraps it so we can apply it to an input string.
newtype Parser a = Parser { runParser :: String -> Result a }


-- ─────────────────────────────────────────────────────────────────────────────
-- Typeclass instances
-- ─────────────────────────────────────────────────────────────────────────────

-- Functor: transform the parsed value without changing the parsing logic.
instance Functor Parser where
  fmap f (Parser p) = Parser $ \input ->
    case p input of
      Left  err        -> Left err
      Right (rest, a)  -> Right (rest, f a)

-- Applicative: sequence two parsers, feeding the leftover from the first
-- into the second.
instance Applicative Parser where
  pure a = Parser $ \input -> Right (input, a)

  Parser pf <*> Parser pa = Parser $ \input ->
    case pf input of
      Left  err       -> Left err
      Right (rest, f) ->
        case pa rest of
          Left  err'        -> Left err'
          Right (rest', a)  -> Right (rest', f a)

-- Alternative: try the first parser; fall back to the second on failure.
-- This also gives us 'many' and 'some' for free.
instance Alternative Parser where
  empty = Parser $ \_ -> Left "no parse"

  Parser p1 <|> Parser p2 = Parser $ \input ->
    case p1 input of
      Left  _      -> p2 input    -- first failed, try second
      Right result -> Right result

-- Monad: chain parsers where the second depends on the result of the first.
instance Monad Parser where
  return = pure

  Parser p >>= f = Parser $ \input ->
    case p input of
      Left  err       -> Left err
      Right (rest, a) -> runParser (f a) rest


-- ─────────────────────────────────────────────────────────────────────────────
-- Primitive parsers
-- ─────────────────────────────────────────────────────────────────────────────

-- | Parse one character satisfying a predicate.
--   This is the most general primitive; everything else is built on it.
satisfy :: (Char -> Bool) -> String -> Parser Char
satisfy p desc = Parser $ \input ->
  case input of
    (x:xs) | p x -> Right (xs, x)
    []            -> Left ("unexpected end of input, expected " ++ desc)
    (x:_)         -> Left ("unexpected '" ++ [x] ++ "', expected " ++ desc)

-- | Parse a specific character.
--   This is the exact definition from the exam question.
charP :: Char -> Parser Char
charP c = Parser $ \input ->
  case input of
    (x:xs) | x == c -> Right (xs, x)
    _               -> Left "character not found"

-- Note: charP c = satisfy (== c) ("'" ++ [c] ++ "'")  -- equivalent one-liner

-- | Parse any single character.
anyChar :: Parser Char
anyChar = satisfy (const True) "any character"

-- | Parse a digit character ('0'..'9').
digit :: Parser Char
digit = satisfy isDigit "digit"

-- | Parse a letter (a-z, A-Z).
letter :: Parser Char
letter = satisfy isAlpha "letter"

-- | Parse a letter or digit.
alphaNum :: Parser Char
alphaNum = satisfy isAlphaNum "alphanumeric"

-- | Parse a single whitespace character.
space :: Parser Char
space = satisfy isSpace "whitespace"


-- ─────────────────────────────────────────────────────────────────────────────
-- Combinators
-- ─────────────────────────────────────────────────────────────────────────────

-- | Try a parser; succeed with Nothing if it fails (never fails itself).
optional :: Parser a -> Parser (Maybe a)
optional p = (Just <$> p) <|> pure Nothing

-- | Parse an exact string, character by character.
--   Uses 'traverse', which sequences the Applicative effects in order.
stringP :: String -> Parser String
stringP = traverse charP

-- | Skip zero or more whitespace characters.
spaces :: Parser ()
spaces = () <$ many space


-- ─────────────────────────────────────────────────────────────────────────────
-- Higher-level parsers
-- ─────────────────────────────────────────────────────────────────────────────

-- | Parse one or more digits as an unsigned Int.
naturalP :: Parser Int
naturalP = read <$> some digit

-- | Parse a signed integer: optional '-' followed by one or more digits.
intP :: Parser Int
intP = do
  sign   <- optional (charP '-')
  digits <- some digit
  let n = read digits
  pure $ case sign of
    Just _  -> negate n
    Nothing -> n

-- | Parse one or more letters as a word.
wordP :: Parser String
wordP = some letter

-- | Parse one or more alphanumeric characters (an identifier-like token).
identP :: Parser String
identP = some alphaNum

-- | Parse two values separated by a given separator, returning a pair.
sepBy2 :: Parser a -> Parser sep -> Parser b -> Parser (a, b)
sepBy2 pa sep pb = do
  a <- pa
  _ <- sep
  b <- pb
  pure (a, b)

-- | Parse a comma-separated pair of integers, e.g. "3,-7".
intPairP :: Parser (Int, Int)
intPairP = sepBy2 intP (charP ',') intP


-- ─────────────────────────────────────────────────────────────────────────────
-- Demo helpers
-- ─────────────────────────────────────────────────────────────────────────────

-- | Pretty-print a Result.
showResult :: Show a => Result a -> String
showResult (Left err)            = "  FAIL    => " ++ err
showResult (Right (rest, val))   = "  OK      => value = " ++ show val
                                ++ "   |  remaining = " ++ show rest

-- | Run a parser on an input string and print the result.
test :: Show a => String -> Parser a -> String -> IO ()
test label parser input = do
  putStrLn $ "  " ++ label
  putStrLn $ showResult (runParser parser input)
  putStrLn ""

-- | Print a section heading.
section :: String -> IO ()
section title = do
  putStrLn $ replicate 60 '─'
  putStrLn $ "  " ++ title
  putStrLn $ replicate 60 '─'
  putStrLn ""


-- ─────────────────────────────────────────────────────────────────────────────
-- Main
-- ─────────────────────────────────────────────────────────────────────────────

main :: IO ()
main = do
  putStrLn ""
  putStrLn "  ╔══════════════════════════════════════════╗"
  putStrLn "  ║      Haskell Parser Demo                 ║"
  putStrLn "  ╚══════════════════════════════════════════╝"
  putStrLn ""

  -- ── charP (exact exam question examples) ─────────────────────────────────
  section "charP  —  parse a specific character"
  test "charP 'a'  on  \"abc\""   (charP 'a')  "abc"
  test "charP 'x'  on  \"abc\""   (charP 'x')  "abc"
  test "charP 'a'  on  \"\""      (charP 'a')  ""

  -- ── digit ────────────────────────────────────────────────────────────────
  section "digit  —  parse a single digit character"
  test "digit  on  \"3abc\""   digit  "3abc"
  test "digit  on  \"abc\""    digit  "abc"

  -- ── many & some (from Alternative) ──────────────────────────────────────
  section "many digit  —  zero or more digits (never fails)"
  test "many digit  on  \"123abc\""   (many digit)  "123abc"
  test "many digit  on  \"abc\""      (many digit)  "abc"

  section "some digit  —  one or more digits (fails on zero)"
  test "some digit  on  \"123abc\""   (some digit)  "123abc"
  test "some digit  on  \"abc\""      (some digit)  "abc"

  -- ── stringP ──────────────────────────────────────────────────────────────
  section "stringP  —  parse an exact string"
  test "stringP \"let\"  on  \"let x = 1\""     (stringP "let")  "let x = 1"
  test "stringP \"let\"  on  \"where x = 1\""   (stringP "let")  "where x = 1"

  -- ── naturalP ─────────────────────────────────────────────────────────────
  section "naturalP  —  unsigned integer"
  test "naturalP  on  \"42 rest\""   naturalP  "42 rest"
  test "naturalP  on  \"0\""         naturalP  "0"
  test "naturalP  on  \"abc\""       naturalP  "abc"

  -- ── intP (signed integer) ────────────────────────────────────────────────
  section "intP  —  signed integer"
  test "intP  on  \"42abc\""    intP  "42abc"
  test "intP  on  \"-17abc\""   intP  "-17abc"
  test "intP  on  \"0\""        intP  "0"
  test "intP  on  \"abc\""      intP  "abc"

  -- ── wordP ────────────────────────────────────────────────────────────────
  section "wordP  —  one or more letters"
  test "wordP  on  \"hello world\""   wordP  "hello world"
  test "wordP  on  \"123abc\""        wordP  "123abc"

  -- ── Composing with Applicative / Monad ───────────────────────────────────
  section "intPairP  —  parse two ints separated by a comma"
  test "intPairP  on  \"3,-7rest\""   intPairP  "3,-7rest"
  test "intPairP  on  \"-1,2\""       intPairP  "-1,2"
  test "intPairP  on  \"x,2\""        intPairP  "x,2"

  -- ── Functor: transform the result ────────────────────────────────────────
  section "Functor  —  fmap transforms the parsed value"
  test "fmap (*2) intP  on  \"21\""          (fmap (*2) intP)          "21"
  test "fmap negate intP  on  \"100rest\""   (fmap negate intP)        "100rest"
  test "fmap length wordP  on  \"hello!\""   (fmap length wordP)       "hello!"

  -- ── Alternative: try one parser then another ─────────────────────────────
  section "Alternative (<|>)  —  try first parser, fall back to second"
  let numOrWord = (fmap show intP) <|> wordP
  test "intP <|> wordP  on  \"42rest\""     numOrWord  "42rest"
  test "intP <|> wordP  on  \"hello world\"" numOrWord  "hello world"
  test "intP <|> wordP  on  \"!invalid\""   numOrWord  "!invalid"

  -- ── optional ─────────────────────────────────────────────────────────────
  section "optional  —  wrap a parser so it never fails"
  test "optional (charP '-') on \"-17\""   (optional (charP '-'))  "-17"
  test "optional (charP '-') on \"17\""    (optional (charP '-'))  "17"

  putStrLn $ replicate 60 '═'
  putStrLn "  Done."
  putStrLn $ replicate 60 '═'
  putStrLn ""

  putStrLn "  Mairead Meagher  |  Functional Programming  |  April  2026"
  print $ runParser (charP 'a') "abc"
  print $ runParser (charP 'x') "abc"

  putStrLn ""