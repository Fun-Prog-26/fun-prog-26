
module Main where

import Text.Pandoc
-- import Text.Pandoc.Builder(plain, text)
-- import Text.Pandoc.Writers.Docx (writeDocx)
import qualified Data.ByteString.Lazy as BL (writeFile)
import Data.Text (pack)
import qualified Data.Foldable as FL (toList) 

main :: IO ()
main = do
    let doc = plain (text (pack "Hello, World!")) -- Create a Pandoc document
    docx <- runIO $ writeDocx def (Pandoc nullMeta (FL.toList doc)) -- Convert the document to Docx format
    case docx of
        Left e -> error (show e) -- If there's an error, throw it
        Right bs -> BL.writeFile "output.docx" bs -- Otherwise, write the ByteString to a file