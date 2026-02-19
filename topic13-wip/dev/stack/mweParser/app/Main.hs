{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import Data.Char (toUpper)
import Data.Vector (Vector)

data Book = Book
    { title :: String
    , author :: String
    , genre:: String
    , pages :: Int
    } deriving Show

instance FromNamedRecord Book where
 parseNamedRecord m = do
  title

parseGenre ::  Parser String ->  Parser String
parseGenre parser = do
    genreText <- parser
    return $ map  toUpper genreText

main :: IO ()
main = do
    csvData <- BL.readFile "data/books.csv"
    case decodeByName csvData of
        Left err -> putStrLn $ "Error: " ++ err
        Right (_, v) -> print (v :: Vector Book)
