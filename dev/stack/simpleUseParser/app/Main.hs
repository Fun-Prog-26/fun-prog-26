{-# LANGUAGE OverloadedStrings, FlexibleInstances #-}

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import Data.Char (toUpper, isSpace)
import Data.Vector (Vector)
import qualified Data.ByteString.Lazy.Char8 as C


data Book = Book
    { title :: String
    , author :: String
    , description ::[String]
    , genre:: String
    , pages :: Int
    } deriving Show

instance FromNamedRecord Book where
    parseNamedRecord m = Book
        <$> m .: "Title"
        <*> m .: "Author"
        <*> m .: "Description"
        <*> m .: "Genre"
        <*> m .: "Pages"


instance FromField [String] where
   parseField field = return $ parseCSVField (BL.fromStrict field)
      where
        -- Define a function to parse CSV field enclosed in double quotes
        parseCSVField :: C.ByteString -> [String]
        parseCSVField = go . C.unpack
          where
            go :: String -> [String]
            go [] = []
            go ('"':rest) = let (field, rest') = parseQuotedField rest in field : go rest'
            go (c:rest) = let (field, rest') = parseUnquotedField (c:rest) in field : go rest'

            parseQuotedField :: String -> (String, String)
            parseQuotedField ('"':rest) = case rest of
                ('"':rest')    -> let (field, rest'') = parseQuotedField rest' in ('"':field, rest'')
                _               -> ("", rest)
            parseQuotedField (c:rest) = let (field, rest') = parseQuotedField rest in (c:field, rest')
            parseQuotedField [] = error "Unexpected end of input while parsing quoted field"
            parseUnquotedField :: String -> (String, String)
            parseUnquotedField = break (\c -> c == ',' || isSpace c)
        

main :: IO ()
main = do
    csvData <- BL.readFile "data/books.csv" 
    case decodeByName csvData of
        Left err -> putStrLn $ "Error: " ++ err
        Right (_, v) -> print (v :: Vector Book)
