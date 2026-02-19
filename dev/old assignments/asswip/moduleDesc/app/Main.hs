{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main (main) where
import System.Environment
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Lib
import ModuleData
import DataParser
import Text.Pandoc
import Text.Pandoc.Builder(plain, text)
import Text.Pandoc.Writers.Docx (writeDocx)
import Text.Pandoc.Writers.Markdown (writeMarkdown)
import qualified Data.ByteString.Lazy as BL (writeFile, ByteString, toStrict, readFile)
import Data.Text (pack)
import qualified Data.Foldable as FL (toList) 
import qualified Data.ByteString as BS
import GHC.Generics
import qualified Data.Vector as V
import Data.Csv

import qualified Data.ByteString.Lazy.Char8 as BL


main :: IO ()
main = do
    -- Read the CSV file
    csvData <- BL.readFile "data/Module_Descriptors_withCredits.csv"
    
    -- Parse the CSV data
    let parsedData = parseCSV csvData
    
    -- Process the parsed data
    case parsedData of
        Left err -> putStrLn $ "Error: " ++ err
        Right records -> do
            putStrLn "Parsed successfully!"
            print records


parseCSV :: BL.ByteString -> Either String (V.Vector ModuleModel)
parseCSV csvData = fmap snd $ decodeByName csvData





getModuleData :: String -> [String]
getModuleData  ms =  tail $ clean $  dropWhile (/= '\n') ms



-- getHeaderData :: String -> [String]
-- getHeaderData xs = splitOn ',' $ takeWhile (/= '\n') xs

-- -- myPrint :: [String] -> IO ()

-- -- myPrint [] = return ()
-- -- myPrint (x:xs) =  putStrLn x >> myPrint xs 

-- flatten' :: [String] -> String
-- flatten' [] = []
-- flatten' (x:xs) = x ++ flatten' xs



-- genListFromWithinQuotes :: String -> [String]
-- genListFromWithinQuotes ('\"': xs)= splitOn ',' $ takeWhile (/= '\"') xs
-- genListFromWithinQuotes _ = []

-- -- parseCSV :: BL.ByteString -> Either String (V.Vector ModuleModel)
-- -- parseCSV csvData = do
-- --     let decoded = decodeByName csvData :: Either String ( V.Vector ModuleModel)
-- --     case decoded of
-- --         Left err -> Left err
-- --         Right (_, records) -> Right records