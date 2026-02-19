{-# LANGUAGE OverloadedStrings #-}

import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import Data.Csv(FromNamedRecord, FromField, parseField, parseNamedRecord, runParser, decodeByName, (.:), FromNamedRecord)
import qualified Data.Vector as V(forM_)
import GHC.Generics (Generic)


data Student = Student
    {
    studentId :: String
    , name   :: String
    , age :: Int
    , avg :: Double
    }

instance FromNamedRecord Student where
  parseNamedRecord r = Student <$> r .: "studentId" <*> r .: "name" <*> r .: "age" <*> r .: "avg"

main :: IO ()
main = do
    csvData <- BL.readFile "students.csv"
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> V.forM_ v $ \ p ->  -- this loops through the [Person] so that we can print out each record.
            putStrLn $ "Student Id: " ++ studentId p++ " Name:  " ++  name p ++ "  Age:  " ++ show (age p)  ++ "  Average Mark:" ++ show (avg p)