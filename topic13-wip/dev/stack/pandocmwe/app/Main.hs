{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import Data.Vector as V (Vector,  toList)

data Book = Book
    { title :: String
    , author :: String
    , genre :: String
    , pages :: String
    } deriving Show

instance FromNamedRecord Book where
    parseNamedRecord m = Book
        <$> m .: "Title"
        <*> m .: "Author"
        <*> m .: "Genre"
        <*> m .: "Pages"



main :: IO ()
main = do
    csvData <- BL.readFile "data/books.csv"
    case decodeByName csvData of
        Left err -> putStrLn $ "Error: " ++ err
        Right (_, v) -> generateMarkdown v

generateMarkdown :: Vector Book -> IO()
-- 
generateMarkdown v = writeFile  "newbooks.md"  (unlines $ 
    [ "# Books"
    , ""
    ] ++ map generateBook (V.toList v))

generateBook :: Book -> String
-- this is like a toString - it generates a string representation of a book. You can add more formatting here. 
-- note unlines is a function that joins a list of strings with newlines (flattens a list of strings into one long one). 
-- It is a standard function in Haskell.
generateBook book = unlines
    [ "## " ++ title book
    ,  author book ++ " - " ++ genre book ++ " - " ++ pages book ++ " pages" ]




 