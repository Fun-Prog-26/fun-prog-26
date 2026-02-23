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
        <$> (m .: "Title")
        <*> m .: "Author"
        <*> m .: "Genre"
        <*> m .: "Pages"

instance FromField [String] where
    parseField field = return $ splitCSV field
      where
        -- Define a function to split CSV string into list of strings
        splitCSV :: BL.ByteString -> [String]
        splitCSV = map (BL.unpack . BL.dropWhile (== ' ')) . BL.split ','



main :: IO ()
main = do
    csvData <- BL.readFile "data/books.csv"
    case decodeByName csvData of
        Left err -> putStrLn $ "Error: " ++ err
        Right (_, v) -> writeToMarkdown (generateMarkdown v)

generateMarkdown :: Vector Book -> String
generateMarkdown v = unlines $ 
    [ "# Books"
    , ""
    ] ++ map generateBook (V.toList v)

generateBook :: Book -> String
generateBook book = unlines
    [ "## " ++ title book
    ,  author book ++ " - " ++ genre book ++ " - " ++ pages book ++ " pages" ]

writeToMarkdown :: String -> IO ()
writeToMarkdown = writeFile "books.md"
 


 