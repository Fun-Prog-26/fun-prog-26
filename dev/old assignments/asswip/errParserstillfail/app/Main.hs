{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
-- this is compiling but failing when parses an incorrectly formed record in a csv file
import Data.Csv
import qualified Data.Vector as V
import Data.Text.Encoding (decodeUtf8)
import GHC.Generics (Generic)
import qualified Data.ByteString.Char8 as BLC
import qualified Data.ByteString.Lazy.Char8 as BL

-- Define a data type for the CSV records
data MyRecord = MyRecord
    { field1 :: Int  -- Changed to Maybe Int
    , field2 :: String
    , field3 :: Double
    } deriving (Show, Generic)


-- Define an instance for the FromNamedRecord typeclass to parse CSV records
instance FromNamedRecord MyRecord where
    parseNamedRecord m = MyRecord
        <$> m .: "Field1"  
        <*> m .: "Field2"
        <*> m .: "Field3"

-- Read the CSV data from a file and handle parsing errors
main :: IO ()
main = do
    csvData <- BL.readFile "data/data.csv"
    let preprocessedData = preprocessCSV csvData
    case decodeByName preprocessedData of
        Left err -> putStrLn $ "Error decoding CSV: " ++ err
        Right (_, v) -> processRecords v

preprocessCSV :: BL.ByteString -> BL.ByteString
preprocessCSV = BL.unlines . map preprocessLine . BL.lines




preprocessLine :: BL.ByteString -> BL.ByteString
preprocessLine line =
    let (field1Value, rest) = BL.break (== ',') line
        processedField1 = if BL.all (\c -> c >= '4' ) field1Value
                            then field1Value
                            else "0"
    in BL.concat [processedField1, rest]

-- Custom filter to separate valid and invalid records
processRecords :: V.Vector MyRecord -> IO ()
processRecords records = do
    let (validRecords, invalidRecords) = V.partition isValidRecord records
    putStrLn "Valid Records:"
    V.forM_ validRecords printRecord
    putStrLn "\nInvalid Records (Skipped):"
    V.forM_ invalidRecords printInvalidRecord

-- Custom filter to skip records with invalid "Field1" values
isValidRecord :: MyRecord -> Bool
isValidRecord (MyRecord (Just f1) _ _) = f1 >= 0
isValidRecord _ = False

-- Print a valid record
printRecord :: MyRecord -> IO ()
printRecord (MyRecord (Just f1) f2 f3) =
    putStrLn $ "Field1: " ++ show f1 ++ ", Field2: " ++ f2 ++ ", Field3: " ++ show f3
printRecord _ = putStrLn "Invalid Record (Missing Field1)"

-- Print an invalid record
printInvalidRecord :: MyRecord -> IO ()
printInvalidRecord record = putStrLn $ "Invalid Record: " ++ show record
