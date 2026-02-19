{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
-- this is compiling but failing when parses an incorrectly formed record in a csv file
import Data.Csv
import qualified Data.Vector as V
import Data.Text.Encoding (decodeUtf8)
import GHC.Generics (Generic)
import qualified Data.ByteString.Char8 as BLC
import qualified Data.ByteString.Lazy.Char8 as BL

import ModuleData 

-- Define a data type for the CSV records



-- Define an instance for the FromNamedRecord typeclass to parse CSV records
instance FromNamedRecord MyRecord where
    parseNamedRecord m = MyRecord
        <$> m .: "Field1"  
        <*> m .: "Field2"
        <*> m .: "Field3"

main :: IO()
main = putStrLn "hello"