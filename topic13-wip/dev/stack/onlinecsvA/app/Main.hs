{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass #-}
import Control.Applicative
import qualified Data.ByteString.Lazy as BL
import Data.Csv(FromNamedRecord, FromField, parseField, parseNamedRecord, runParser, decodeByName, (.:), FromNamedRecord)
import qualified Data.Vector as V(forM_)
import GHC.Generics (Generic)

newtype DefaultInt = DefI Int 

data Person = Person
    { name   :: String
    , salary :: Int
    } deriving (Show)

instance FromNamedRecord Person where
  parseNamedRecord r = Person <$> r .: "name" <*> r .: "salary"


main :: IO ()
main = do
    csvData <- BL.readFile "salaries.csv"
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> V.forM_ v $ \ p ->      -- This loops through the [Person] vector to print out all records
            putStrLn$ name p ++ " earns " ++ show (salary p) ++ " dollars"