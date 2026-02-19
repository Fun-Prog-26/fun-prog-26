{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import qualified Data.ByteString.Lazy as BL
import Data.Csv
import qualified Data.Vector as V
import GHC.Generics (Generic)



data Student = Student
    { studentId :: String
    , name      :: String
    , age       :: Int
    , avg       :: Double
    , credits   :: Int
    } deriving (Show, Generic)

-- Define custom parser for credits
parseCredits :: Int -> Parser Int
parseCredits c =
    if creditsProp c
        then pure c
        else fail "Invalid credits"

-- Check if credits are divisible by 5 and less than or equal to 240
creditsProp :: Int -> Bool
creditsProp c = c `mod` 5 == 0 && c <= 240


parseAge :: Int -> Parser Int
parseAge a =
    if a < 90
        then pure a
        else fail "Invalid age"

-- Define FromNamedRecord instance for Student
instance FromNamedRecord Student where
    parseNamedRecord r = do
        studentId' <- r .: "studentId"
        name'      <- r .: "Name"
        age'       <- r .: "age" >>= parseAge
        avg'       <- r .: "avg"
        credits'   <- r .: "credits" >>= parseCredits
        return $ Student studentId' name'  age' avg' credits'

main :: IO ()
main = do
    csvData <- BL.readFile "students.csv"
    case decodeByName csvData of
        Left err -> putStrLn $ "Error parsing CSV: " ++ err
        Right (_, v) -> V.forM_ v $ \p ->
            putStrLn $ studentId p ++ " Name:  " ++ name p ++ "  Age:  " ++
                show (age p) ++ "  Average:  " ++ show (avg p) ++ "  Credits:  " ++ show (credits p)
