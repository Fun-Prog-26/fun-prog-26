{-# LANGUAGE DeriveGeneric, DeriveAnyClass, FlexibleInstances, InstanceSigs #-}

module ModuleData where

import qualified Data.Text as T
import Data.Csv
import GHC.Generics (Generic)
import Data.Either(isRight)
import qualified Data.List as L
import qualified Data.Vector as V
import qualified Data.Char  as C

import qualified Data.Text.Encoding as TE


import qualified Data.ByteString.Char8 as B
import Data.Text.Internal.Encoding.Utf32 (validate)
import Data.ByteString (all)

-- Define the Module data type
data Module = Module {
    code :: T.Text,
    fullTitle :: T.Text,
    shortTitle :: T.Text,
    credits :: Int,
    level :: T.Text,
    aims :: [T.Text],
    department :: T.Text,
    indContent :: [T.Text],
    learnOutcomes :: [T.Text],
    assessmentCriteria :: [T.Text]
} deriving (Show, Eq, Generic)

-- Titles on csv file
-- Code,Full_Title,Short_Title,Credits,Level,Aim,Department,Indicative_Content,Learning_Outcomes,Assessment_Criteria


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


-- Custom FromField instance for [Text]
instance FromField [T.Text] where
    parseField :: Field -> Parser [T.Text]
    parseField field = return $ splitOnSpace $ removeQuotes $ TE.decodeUtf8 field
      where
        removeQuotes :: T.Text -> T.Text
        removeQuotes = T.dropAround (`Prelude.elem` ['"', '\''])

        splitOnSpace :: T.Text -> [T.Text]
        splitOnSpace = T.splitOn (T.pack " ")


data ValidatedModule = ValidatedModule {
    code_val :: Either T.Text T.Text,
    fullTitle_val :: Either T.Text T.Text,
    shortTitle_val :: Either T.Text T.Text,
    credits_val :: Either T.Text Int,
    level_val :: Either T.Text T.Text,
    aims_val :: Either T.Text [T.Text],
    department_val :: Either T.Text T.Text,
    indContent_val :: Either T.Text [T.Text],
    learnOutcomes_val :: Either T.Text [T.Text],
    assessmentCriteria_val :: Either T.Text [T.Text]
} deriving (Show, Eq, Generic)

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

validateCode :: T.Text -> Either T.Text T.Text
validateCode code = if C.isAlpha (T.head code)&&C.isUpper (T.head code) && Prelude.all C.isDigit (Prelude.tail $ T.unpack  code) && T.length code >= 6 && T.length code <= 9
    then Right code
    else Left $ T.pack "Module Code Error : First Character must be a letter, the rest must be digits and the length of the code must be between 6 and 9 chars (Letter included). Incorrect code:" `T.append` code

validateText :: T.Text -> Either T.Text T.Text
validateText text = if T.length text > 0 then Right text else Left $ T.pack "Text must not be empty"

validateTextList :: [T.Text] -> Either T.Text [T.Text]
validateTextList texts = if Prelude.length texts > 0 then Right texts else Left $ T.pack  "List must not be empty"

validateInt :: Int -> Either T.Text Int
validateInt int = if int > 0 then Right int else Left $ T.pack "Int must be greater than 0"

validateCredits :: Int -> Either T.Text Int
validateCredits credits = if credits >= 0 && credits <= 30 && credits `mod` 5 == 0 then Right credits else Left $ T.pack "Credits must be between 0 and 30 and divisible by 5. Incorrect credits: " `T.append` (T.pack $ show credits)



-- Check if all fields are Right
allFieldsValid :: ValidatedModule -> [Bool]
allFieldsValid mod = 
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


    -- csvData <- BL.readFile "data/Module_Descriptors.csv"
    -- case decodeByName csvData :: Either String (Header, V.Vector Module) of
    --     Left err -> putStrLn $ "Error decoding CSV: " ++ err
    --     Right (_, v) -> do
    --       let boolList = allFieldsValid $ validateModule $ V.head v
    --       printBoolList boolList

checkAreAllFieldsInModuleValid ::  Module -> Bool
checkAreAllFieldsInModuleValid m = and $ allFieldsValid $ validateModule  m

getAllCodes :: V.Vector Module -> V.Vector T.Text
getAllCodes  = V.map code


-- allCodesUnqiue :: V.Vector Module -> Bool
-- allCodesUnqiue v = V.length (V.map code v) == V.length (L.nub $ V.toList $ V.map code v)

-- codeNotAlreadyExists :: V.Vector Module -> T.Text -> Bool
-- codeNotAlreadyExists v code = code `L.notElem` V.toList (V.map code v)

instance DefaultOrdered ValidatedModule where
    headerOrder _ = header
      where
        header :: V.Vector Name
        header = V.fromList ["Module Code", "Short Title", "Full Title", "Credits", "Level" ,"Aims","Department","Indicative Content","Learning Outcomes","Assessment Criteria"]

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

newtype MyText = MyText T.Text

instance Data.Csv.ToField MyText where
    toField (MyText t) = Data.Csv.toField t

instance (ToField a, ToField b) => ToField (Either a b) where
    toField (Left x) = toField x
    toField (Right x) = toField x

instance ToField [T.Text] where
    toField = Data.Csv.toField . T.intercalate (T.pack ", ")

