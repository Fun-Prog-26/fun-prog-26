-- Main.hs
{-# LANGUAGE OverloadedStrings #-}

import Catalogue
import Lib (parseCatalogue, writeCatalogueMarkdown)
import Text.XML
import Text.XML.Cursor
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.List.NonEmpty (NonEmpty(..))
import qualified Data.List.NonEmpty as NE
import Data.Maybe (fromMaybe)
import Control.Monad (forM)

main :: IO ()
main = do
    doc <- Text.XML.readFile def "books.xml"
    let catalogue = parseCatalogue doc
    print catalogue
    writeCatalogueMarkdown "catalogue.md" catalogue
    putStrLn "Written to catalogue.md"