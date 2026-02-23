module Main (main) where

import ModuleData
import Data.Csv
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import System.Process   
import Text.Pandoc


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
        let inputFile = "data/ValidatedModule_Descriptors.csv"
            outputFile = "validmodules.md"
    -- Convert .docx to HTML using Pandoc
        _       <- system $ "pandoc -s " ++ inputFile ++ " -o temp.html"
    -- Convert HTML to Markdown using Pandoc
        _ <- system $ "pandoc -s temp.html -o " ++ outputFile
    -- Clean up temporary HTML file
--     _ <- system "rm temp.html"
        putStrLn "Conversion complete."


buildLogs ::  V.Vector Module ->  (V.Vector ValidatedModule, V.Vector ValidatedModule)
buildLogs v = (invalid, valid)
    where
        (invalidM, validM) = V.partition (not . checkAreAllFieldsInModuleValid)  v 
        invalid = V.map validateModule invalidM
        valid = V.map validateModule validM



printTextList :: V.Vector ValidatedModule -> IO ()
printTextList v = V.forM_ v printTextOnlyList

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

makeString :: Either String String -> String
makeString (Left x) = x
makeString (Right x) = x

makeStringFromInt :: Either String Int -> String
makeStringFromInt (Left x) =  x
makeStringFromInt (Right x) = show x


writeCSV :: FilePath -> V.Vector ValidatedModule -> IO ()
writeCSV filePath vdata = do
    let header = headerOrder (undefined :: ValidatedModule)
        records = V.toList vdata
    BL.writeFile filePath $ encodeByName header records
