{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( parseCatalogue
    , writeCatalogueMarkdown
    ) where

import Catalogue
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Text.XML
import Text.XML.Cursor
import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.List.NonEmpty as NE

parseCatalogue :: Document -> Catalogue
parseCatalogue doc =
    let cursor = fromDocument doc
        books  = cursor $// element "book"
    in Catalogue (map parseBook books)

parseBook :: Cursor -> Book
parseBook c =
    let isbn      = ISBN $ head (attribute "isbn" c)
        title     = innerText $ head (c $/ element "title")
        subtitleC = c $/ element "subtitle"
        subtitle  = if null subtitleC
                      then Nothing
                      else Just (innerText $ head subtitleC)
        year      = read . T.unpack . head $ ((c $/ element "published") >>= attribute "year")
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

innerText :: Cursor -> T.Text
innerText c = T.concat (c $// content)

-- | Render a Catalogue as Markdown and write it to a file
writeCatalogueMarkdown :: FilePath -> Catalogue -> IO ()
writeCatalogueMarkdown path cat =
    TIO.writeFile path (catalogueToMarkdown cat)

catalogueToMarkdown :: Catalogue -> T.Text
catalogueToMarkdown cat =
    T.unlines $ ["# Book Catalogue", ""] ++ concatMap bookToMarkdown (catalogueBooks cat)

bookToMarkdown :: Book -> [T.Text]
bookToMarkdown b =
    let ISBN isbn     = bookIsbn b
        authors       = T.intercalate ", " . map authorName . NE.toList $ bookAuthors b
        titleLine     = "## " <> bookTitle b
        subtitleLines = case bookSubtitle b of
                          Nothing -> []
                          Just s  -> ["*" <> s <> "*", ""]
        details       = [ "- **ISBN:** " <> isbn
                        , "- **Authors:** " <> authors
                        , "- **Year:** " <> T.pack (show (bookYear b))
                        , ""
                        ]
    in [titleLine] ++ subtitleLines ++ details
