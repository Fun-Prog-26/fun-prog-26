{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}
-- this is compiling but failing when parses an incorrectly formed record in a csv file
import Data.Csv
import qualified Data.Vector as V
import Data.Text.Encoding (decodeUtf8)
import GHC.Generics (Generic)
import qualified Data.ByteString.Char8 as BLC
import qualified Data.ByteString.Lazy.Char8 as BL
import qualified Data.Text as T

import ModuleData 

import Data.Bool (bool)
import Control.Monad (Functor(fmap))
import Data.Vector (Vector) -- Add this import


-- Define a data type for the CSV records



-- Define an instance for the FromNamedRecord typeclass to parse CSV records

main :: IO ()
main = do
        csvData <- BL.readFile "data/Module_Descriptors.csv"
        case decodeByName csvData of
                Left err -> putStrLn $ "Error decoding CSV: " ++ err
                Right (_, v) -> do
                    let (errors, valids) = buildLogs   v
                    putStrLn "Invalid Modules  ******************************"
                    printTextList  errors
                    putStrLn "Valid Modules  ******************************"
                    printTextList  valids
                    putStrLn "End of Modules  ******************************"
                    putStrLn   "Number of Invalid Module Descriptors" 
                    print $ V.length errors
                    putStrLn   "Number of Valid Module Descriptors" 
                    print $ V.length valids
                    putStrLn  "End of Modules  ******************************"
                    writeCSV "data/ValidatedModule_Descriptors.csv" valids
                    writeCSV "data/InvalidModule_Descriptors.csv" errors

printTextList :: V.Vector ValidatedModule -> IO ()
printTextList v = V.forM_ v printTextOnlyList


-- printTextOnlyList :: ValidatedModule -> IO ()
printTextOnlyList :: ValidatedModule -> IO ()
printTextOnlyList m = do
    putStrLn $ "Code: " ++ ( makeString . code_val)  m
    putStrLn $ "Full Title: " ++ (makeString . fullTitle_val )m
    putStrLn $ "Short Title: " ++ (makeString .  shortTitle_val) m
    putStrLn $ "Credits: " ++ (makeStringFromInt . credits_val) m
    -- putStrLn $ "Level: " ++ (T.unpack $ level m)
    -- putStrLn $ "Aims: " ++ (show $ aims m)
    -- putStrLn $ "Department: " ++ (T.unpack $ department m)
    -- putStrLn $ "Indicative Content: " ++ (show $ indContent m)
    -- putStrLn $ "Learning Outcomes: " ++ (show $ learnOutcomes m)
    -- putStrLn $ "Assessment Criteria: " ++ (show $ assessmentCriteria m)
    putStrLn "-----------------------------------"


printBoolList :: [Bool] -> IO ()
printBoolList [] = putStrLn ""
printBoolList (x:xs) = do
    
    printBoolList xs

makeString :: Either T.Text T.Text -> String
makeString (Left x) = T.unpack x
makeString (Right x) = T.unpack x

makeStringFromInt :: Either T.Text Int -> String
makeStringFromInt (Left x) = T.unpack x
makeStringFromInt (Right x) = show x

buildLogs ::  V.Vector Module ->  (V.Vector ValidatedModule, V.Vector ValidatedModule)
buildLogs v = (invalid, valid)
    where
        (invalidM, validM) = V.partition (not . checkAreAllFieldsInModuleValid)  v 
        invalid = V.map validateModule invalidM
        valid = V.map validateModule validM



writeCSV :: FilePath -> V.Vector ValidatedModule -> IO ()
writeCSV filePath vdata = do
    let header = headerOrder (undefined :: ValidatedModule)
        records = V.toList vdata
    BL.writeFile filePath $ encodeByName header records