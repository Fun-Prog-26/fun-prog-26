module Main (main) where
import ProcessStrings
import ModuleData
import System.Environment

main :: IO ()
main = do
     (file:_) <- getArgs    -- getArgs returns a List of Strings so we are binding 
                            -- the first  String to file using pattern matching
                            -- to run this, use 
                            --       ass1-phase1-exe "data/phase1.csv"
                   
     moduleData <- readFile file -- Having read this in as a flat String we use buildModule to build up a Module
                                 -- We print below just to test the running of the building code
     putStrLn "Module Code : "
     print $ moduleCode (buildModule moduleData ) 
     putStrLn "\n Full title : "
     print $ moduleFullTitle (buildModule moduleData)
     putStrLn "\n Indicative Content : "
     print $ moduleIndContent (buildModule moduleData )
     putStrLn "\n Learning OutComes : "
     print $ moduleLearningOutcomes (buildModule moduleData )
   
