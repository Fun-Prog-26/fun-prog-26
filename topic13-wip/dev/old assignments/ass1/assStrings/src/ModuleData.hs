{-# LANGUAGE DeriveGeneric, DeriveAnyClass, FlexibleInstances #-}

module ModuleData where

import Data.Csv
import qualified Data.Char as C
import GHC.Generics (Generic)
import qualified Data.ByteString.Char8 as B(pack)
import Data.List.Split (splitOn)
import Data.Either(isRight)
import Data.Vector as V (Vector,  partition, fromList, forM_)
import Data.List (intercalate)

-- Define the Module data type
data Module = Module {
    code :: String,
    fullTitle :: String,
    shortTitle :: String,
    credits :: Int,
    level :: String,
    aims :: [String],
    department :: String,
    indContent :: [String],
    learnOutcomes :: [String],
    assessmentCriteria :: [String]
} deriving (Show, Eq, Generic)

instance FromNamedRecord Module where
    parseNamedRecord m = Module
        <$> m .: B.pack "Code"
        <*> m .: B.pack "Full_Title"
        <*> m .: B.pack "Short_Title"
        <*> m .: B.pack "Credits"
        <*> m .: B.pack "Level"
        <*> m .: B.pack "Aim"
        <*> m .: B.pack "Department"
        <*> m .: B.pack "Indicative_Content"
        <*> m .: B.pack "Learning_Outcomes"
        <*> m .: B.pack "Assessment_Criteria"


data ValidatedModule = ValidatedModule {
    code_val :: Either String String,
    fullTitle_val :: Either String String,
    shortTitle_val :: Either String String,
    credits_val :: Either String Int,
    level_val :: Either String String,
    aims_val :: Either String [String],
    department_val :: Either String String,
    indContent_val :: Either String [String],
    learnOutcomes_val :: Either String [String],
    assessmentCriteria_val :: Either String [String]
} deriving (Show, Eq, Generic)

instance FromField [String] where
    parseField = fmap (splitOn ",") . parseField

validateModule :: Module -> ValidatedModule
validateModule m = ValidatedModule {
    code_val = validateCode $ code m,
    fullTitle_val = validateText $ fullTitle m,
    shortTitle_val = validateText $ shortTitle m,
    credits_val = validateCredits $ credits m,
    level_val = validateText $ level m,
    aims_val = validateTextList $ aims m,
    department_val = validateText $ department m,
    indContent_val = validateTextList $ indContent m,
    learnOutcomes_val = validateTextList $ learnOutcomes m,
    assessmentCriteria_val = validateTextList $ assessmentCriteria m
}

validateCode :: String -> Either String String
validateCode code = if C.isAlpha (head code) && C.isUpper (head code) && all C.isDigit (tail code) && length code >= 6 && length code <= 9
    then Right code
    else Left $ "Module Code Error: First Character must be a letter, the rest must be digits, and the length of the code must be between 6 and 9 chars (Letter included). Incorrect code: " ++ code

validateText :: String -> Either String String
validateText text = if length text > 0 then Right text else Left "Text must not be empty"

validateTextList :: [String] -> Either String [String]
validateTextList texts = if length texts > 0 then Right texts else Left "List must not be empty"

validateInt :: Int -> Either String Int
validateInt int = if int > 0 then Right int else Left "Int must be greater than 0"

validateCredits :: Int -> Either String Int
validateCredits credits = if credits >= 0 && credits <= 30 && credits `mod` 5 == 0 then Right credits else Left $ "Credits must be between 0 and 30 and divisible by 5. Incorrect credits: " ++ show credits

allFieldsValid :: ValidatedModule -> Bool
allFieldsValid mod = and 
    [ isRight $ code_val mod
    , isRight $ fullTitle_val mod
    , isRight $ shortTitle_val mod
    , isRight $ credits_val mod
    , isRight $ level_val mod
    , isRight $ aims_val mod
    , isRight $ department_val mod
    , isRight $ indContent_val mod
    , isRight $ learnOutcomes_val mod
    ]
checkAreAllFieldsInModuleValid ::  Module -> Bool
checkAreAllFieldsInModuleValid  = allFieldsValid . validateModule  

instance DefaultOrdered ValidatedModule where
    headerOrder _ = header
      where
        header :: V.Vector Name
        header = V.fromList  [B.pack "Module Code", B.pack "Short Title", B.pack "Full Title", B.pack "Credits", B.pack "Level" ,B.pack "Aims",B.pack "Department",B.pack "Indicative Content",B.pack "Learning Outcomes",B.pack "Assessment Criteria"]

instance ToNamedRecord ValidatedModule where
    toNamedRecord (ValidatedModule code_val shortTitle_val  fullTitle_val  credits_val level_val 
                                    aims_val department_val  indContent_val  learnOutcomes_val assessmentCriteria_val) =
        namedRecord
            [ 
              B.pack "Module Code" .= code_val
            , B.pack  "Short Title" .= shortTitle_val
            , B.pack "Full Title"  .= fullTitle_val
            , B.pack "Credits"     .= credits_val
            , B.pack "Level"       .= level_val
            , B.pack "Aims"        .= aims_val
            , B.pack  "Department"  .= department_val
            , B.pack  "Indicative Content"  .= indContent_val
            , B.pack  "Learning Outcomes"   .= learnOutcomes_val
            , B.pack  "Assessment Criteria" .= assessmentCriteria_val 
            ]
-- nstance Data.Csv.ToField MyText where
--     toField (MyText t) = Data.Csv.toField t

instance (ToField a, ToField b) => ToField (Either a b) where
    toField (Left x) = toField x
    toField (Right x) = toField x

instance ToField [String] where
    toField = toField . intercalate  ", " 

