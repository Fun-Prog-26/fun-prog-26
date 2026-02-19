{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE RecordWildCards #-}

module DataParser where
import Data.Csv
import GHC.Generics
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Data.Text.Encoding (decodeUtf8)
import Data.Text (unpack, Text)
import qualified Data.Text as T
import qualified Data.ByteString.Char8 as BS
import Data.List.Split(splitOn)



data ModuleModel = ModuleModel {
    moduleCode :: String,
    moduleFullTitle :: String,
    moduleCredits :: Int,
    moduleLevel :: String,
    moduleIndContent :: [String],
    moduleLearningOutcomes :: [String]
    -- modulePath :: String,
    -- moduleImports :: [String],
    -- moduleExports :: [String],
    -- moduleFunctions :: [String],
    -- moduleTypeDeclarations :: [String],
    -- moduleDataDeclarations :: [String],
    -- moduleClassDeclarations :: [String],
    -- moduleInstanceDeclarations :: [String],
    -- moduleComment :: String
} deriving (Show, Eq)

instance FromNamedRecord ModuleModel where
    parseNamedRecord r = ModuleModel 
                  <$> r .: "Code" 
                  <*> r .: "Full_Title" 
                  <*> r .: "Credits" 
                  <*> r .: "Level" 
                  <*> r .: "Indicative_Content"
                  <*> r .: "Learning_Outcomes"

-- Custom instance to parse semicolon-separated strings within double quoted fields into lists of strings

-- Custom instance to parse comma-separated strings within double quoted fields into lists of strings
instance FromField [String] where
    parseField s = return $ splitOn "," (removeQuotes s)
      where
        removeQuotes = init . tail . unpack . decodeUtf8

-- instance FromField [String] where
--     parseField s = return $ map unpackString $ V.toList $ V.filter (/= "") $ V.map trimSpaces $ V.fromList $ splitOn ';' (encodeUtf8 s)
--       where unpackString = unpack . decodeUtf8



-- -- Define the function with ByteString input and Text output
-- unpackString :: BS.ByteString -> Text
-- unpackString = TE.decodeUtf8

-- -- Define trimSpaces function
-- trimSpaces :: Text -> Text
-- trimSpaces = T.strip . T.stripStart . T.stripEnd

-- -- Now, you can use unpackString in your parseField function
-- parseField' :: BS.ByteString -> [Text]
-- parseField' s = map (trimSpaces . unpackString) $ filter (not . BS.null) $ BS.split ';' s
