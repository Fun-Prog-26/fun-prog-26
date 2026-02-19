module ProcessStrings
    (  buildModule
    ) where
import ModuleData
import Data.List.Split (splitOn)
import qualified  Data.Text as T



splitString :: String -> Char -> (String, String)
splitString str delim =
    let (before, after) = break (== delim) str
    in (before,  drop 1 after)  -- drop the delimiter from the 'after' part I just deleted  drop 1


getNextDelimitedString :: String -> Char -> (String, String)
getNextDelimitedString str delim = (nextString, nextAfter)
    where (_, after) = splitString str delim
          (nextString, nextAfter) = splitString after delim
  

buildModule :: String  -> Module
buildModule moduleData = Module {
    -- Remove the unnecessary 'let' keyword
      moduleCode = T.pack code,
      moduleFullTitle =  T.pack fullTitle,
      moduleIndContent =  map T.pack (makeList indic),
      moduleLearningOutcomes = map T.pack  (makeList los)
      }

    where
        (code, rest) =   splitString moduleData ','
        (fullTitle, nextAfter) = splitString rest ','
        (indic, nextAfter2) = getNextDelimitedString nextAfter '"'
        (los, nextAfter3) = getNextDelimitedString nextAfter2 '"'
          
makeList :: String -> [String]  
makeList = splitOn "\n"
