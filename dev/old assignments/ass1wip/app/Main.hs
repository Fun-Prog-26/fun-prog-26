{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import ModuleParser
import FormatModules
import Validation


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
            print "Credits:     "
            print $ getAllCredits $ V.toList records
            print "*************************************************"
            print "Learning Outcomes:     "
            print $ getAllLearningOutcomes $ V.toList records
            print "\n*************************************************\n"
            let moduleModels = V.toList records

    -- Format and print each ModuleModel
            mapM_ (putStrLn . formatModule) moduleModels
           -- putStrLn $ fmap formatModule records

    print $ isValid "hello  "
     

