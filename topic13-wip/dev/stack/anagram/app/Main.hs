module Main (main) where
import qualified Data.Text as T

import Lib (makeTitle)

data Tree = Note String | Section String [Tree] deriving (Show)




main :: IO ()
main = do 
    let x =  makeListOfStrings "a \n  sdfsdfsdf \n   c"
    print x

-- f :: IO ()
-- f = do 
   
--     --putStrLn
--    let x =  makeListOfStrings "a \n  sdfsdfsdf \n   c"
--    print x
--    

makeListOfStrings :: String -> [String]   
makeListOfStrings [] = []
makeListOfStrings s = let (beforeA, afterA) = break (== '\n') s
             in beforeA : case afterA of
                            [] -> []
                            (_:rest) -> makeListOfStrings rest