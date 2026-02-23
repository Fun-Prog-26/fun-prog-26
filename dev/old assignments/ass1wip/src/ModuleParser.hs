{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE FlexibleInstances #-}



module ModuleParser where
import Data.Csv
import qualified Data.Vector as V
import qualified Data.ByteString.Lazy as BL
import GHC.Generics
import Data.Text.Encoding (decodeUtf8)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.ByteString.Char8 as BS
import Data.List.Split(splitOn)





data ModuleModel = ModuleModel {
    moduleCode :: Text,
    moduleFullTitle :: Text,
    moduleCredits :: Int,
    moduleLevel :: Text,
    moduleIndContent :: [Text],
    moduleLearningOutcomes :: [Text]
    -- modulePath :: String,
    -- moduleImports :: [String],
    -- moduleExports :: [String],
    -- moduleFunctions :: [String],
    -- moduleTypeDeclarations :: [String],
    -- moduleDataDeclarations :: [String],
    -- moduleClassDeclarations :: [String],
    -- moduleInstanceDeclarations :: [String],
    -- moduleComment :: String
} deriving (Show, Eq, Generic)

instance FromNamedRecord ModuleModel where
    parseNamedRecord r = ModuleModel 
                  <$> r .: "Code" 
                  <*> r .: "Full_Title" 
                  <*> r .: "Credits" 
                  <*> r .: "Level" 
                  <*> r .: "Indicative_Content"
                  <*> r .: "Learning_Outcomes"



instance FromField [Text] where
    parseField bs = case TE.decodeUtf8' bs of
        Left err -> fail $ "Error decoding UTF-8: " ++ show err
        Right txt -> return $ T.splitOn ";" txt

parseCSV :: BL.ByteString -> Either String (V.Vector ModuleModel)
parseCSV csvData = fmap snd $ decodeByName csvData

getAllCredits :: [ModuleModel] -> [Int]
getAllCredits xs = map moduleCredits xs


getAllLearningOutcomes :: [ModuleModel] -> [[Text]]   
getAllLearningOutcomes xs = map moduleLearningOutcomes xs

