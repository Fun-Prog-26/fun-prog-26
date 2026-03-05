
 
module Lib
    ( parseCatalogue
    ) where

import Catalogue
import qualified  Data.Text as T
import Text.XML
import Text.XML.Cursor
import Data.List.NonEmpty (NonEmpty(..))

parseCatalogue :: Document -> Catalogue
parseCatalogue doc =
    let cursor = fromDocument doc
        books  = cursor $/ element "catalogue" &/ element "book"
    in Catalogue (map parseBook books)

parseBook :: Cursor -> Book
parseBook c =
    let isbn      = ISBN $ head (attribute "isbn" c)
        title     = innerText $ head (c $/ element "title")
        subtitleC = c $/ element "subtitle"
        subtitle  = if null subtitleC
                      then Nothing
                      else Just (innerText $ head subtitleC)
        year      = read . T.unpack . innerText $ head (c $/ element "year")
        authors   = parseAuthors c
    in Book isbn title subtitle authors year

parseAuthors :: Cursor -> NonEmpty Author
parseAuthors c =
    case map parseAuthor (c $/ element "authors" &/ element "author") of
        (a:as) -> a :| as
        []     -> error "Book must have at least one author"

parseAuthor :: Cursor -> Author
parseAuthor c =
    let aid  = AuthorId $ head (attribute "id" c)
        name = innerText c
    in Author aid name