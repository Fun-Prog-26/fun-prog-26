-- ParseBooks.hs
-- Parses a book catalogue XML file and prints it to the screen.
--
-- Dependencies (add to your .cabal or install via cabal/stack):
--   xml-light   (cabal install xml-light)
--
-- Compile:  ghc -package xml-light ParseBooks.hs -o ParseBooks
-- Run:      ./ParseBooks books.xml

module Main where

import Text.XML.Light          -- xml-light: Element, findChildren, findAttr, etc.
import Data.Maybe (fromMaybe)
import System.Environment (getArgs)
import System.Exit (exitFailure)

-- ─────────────────────────────────────────────
-- Data types
-- ─────────────────────────────────────────────

data Author = Author
  { authorId   :: String
  , authorName :: String
  } deriving (Show)

data Book = Book
  { isbn      :: String
  , title     :: String
  , subtitle  :: Maybe String   -- optional element
  , authors   :: [Author]
  , pubYear   :: String
  } deriving (Show)

-- ─────────────────────────────────────────────
-- Parsing helpers
-- ─────────────────────────────────────────────

-- xml-light uses QName for element names.
-- `unqual` makes a QName with no namespace prefix.
named :: String -> QName
named = unqual

-- Get the text content of an element's first child text node.
getText :: Element -> String
getText = concatMap cdData . onlyText . elContent

-- Parse a single <author> element.
parseAuthor :: Element -> Author
parseAuthor el = Author
  { authorId   = fromMaybe "" (findAttr (named "id") el)
  , authorName = getText el
  }

-- Parse a single <book> element.
parseBook :: Element -> Book
parseBook el = Book
  { isbn     = fromMaybe "unknown" (findAttr (named "isbn") el)
  , title    = maybe "" getText (findChild (named "title") el)
  , subtitle = fmap getText (findChild (named "subtitle") el)
  , authors  = map parseAuthor authorEls
  , pubYear  = fromMaybe "unknown" $ do
                 pub <- findChild (named "published") el
                 findAttr (named "year") pub
  }
  where
    authorsEl = findChild (named "authors") el
    authorEls = maybe [] (findChildren (named "author")) authorsEl

-- Parse the root <catalogue> element into a list of Books.
parseCatalogue :: Element -> [Book]
parseCatalogue root = map parseBook (findChildren (named "book") root)

-- ─────────────────────────────────────────────
-- Pretty printing
-- ─────────────────────────────────────────────

printAuthor :: Author -> IO ()
printAuthor a =
  putStrLn $ "      [" ++ authorId a ++ "] " ++ authorName a

printBook :: Int -> Book -> IO ()
printBook n b = do
  putStrLn $ "Book " ++ show n ++ ":"
  putStrLn $ "  ISBN     : " ++ isbn b
  putStrLn $ "  Title    : " ++ title b
  case subtitle b of
    Nothing  -> return ()
    Just sub -> putStrLn $ "  Subtitle : " ++ sub
  putStrLn   "  Authors  :"
  mapM_ printAuthor (authors b)
  putStrLn $ "  Published: " ++ pubYear b
  putStrLn ""

-- ─────────────────────────────────────────────
-- Main
-- ─────────────────────────────────────────────

main :: IO ()
main = do
  args <- getArgs
  filePath <- case args of
    [f] -> return f
    _   -> do
             putStrLn "Usage: ParseBooks <file.xml>"
             exitFailure

  contents <- readFile filePath

  -- parseXMLDoc returns Maybe Element (the root element).
  case parseXMLDoc contents of
    Nothing   -> putStrLn "Error: could not parse XML." >> exitFailure
    Just root -> do
      let books = parseCatalogue root
      putStrLn $ "Catalogue contains " ++ show (length books) ++ " book(s):\n"
      mapM_ (uncurry printBook) (zip [1..] books)
