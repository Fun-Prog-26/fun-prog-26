{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}


module ModuleData where


import qualified Data.Char as C
import GHC.Generics


-- data ModuleModel = ModuleModel {
--     moduleCode :: String,
--     moduleFullTitle :: String,
--     moduleCredits :: Int,
--     moduleIndContent :: [String],
--     moduleLearningOutcomes :: [String]
--     -- modulePath :: String,
--     -- moduleImports :: [String],
--     -- moduleExports :: [String],
--     -- moduleFunctions :: [String],
--     -- moduleTypeDeclarations :: [String],
--     -- moduleDataDeclarations :: [String],
--     -- moduleClassDeclarations :: [String],
--     -- moduleInstanceDeclarations :: [String],
--     -- moduleComment :: String
-- } deriving (Show, Eq)
 
data HeaderModel = HeaderModel {
    headerModuleCode :: String,
    headerModuleFullTitle :: String,
    headerModuleCredits :: String,
    headerModuleIndContent :: String,
    headerModuleLearningOutcomes :: String
} deriving (Show, Eq, Generic)


-- moduleData :: [String] -> ModuleModel
-- moduleData t = ModuleModel {
--     moduleCode = getModuleCode t,
--     moduleFullTitle = getModuleFullTitle t,
--     moduleCredits = getModuleCredits t,
--     moduleIndContent= getModuleIndContent t,
--     moduleLearningOutcomes = getModuleLearningOutcomes t
--     -- modulePath = getModulePath t,x 
--     -- moduleImports = getModuleImports t,
--     -- moduleExports = getModuleExports t,
--     -- moduleFunctions = getModuleFunctions t,
--     -- moduleTypeDeclarations = getModuleTypeDeclarations t,
--     -- moduleDataDeclarations = getModuleDataDeclarations t,
--     -- moduleClassDeclarations = getModuleClassDeclarations t,
--     -- moduleInstanceDeclarations = getModuleInstanceDeclarations t,
--     -- moduleComment = getModuleComment t
-- }

headerData :: [String] -> HeaderModel
headerData (mCode:mTitle:mCredits:mIndContent:mLearningOutcomes:_) = HeaderModel {
    headerModuleCode = mCode,
    headerModuleFullTitle = mTitle,
    headerModuleCredits = mCredits,
    headerModuleIndContent = mIndContent,
    headerModuleLearningOutcomes = mLearningOutcomes
}

-- These are the functions that will be used to extract the data from the module description for one module
getModuleCode :: [String] -> String   -- no validation yet
getModuleCode (t:_) = if True then t else "Module heading is missing or incorrectly formatted"

getModuleFullTitle :: [String] -> String
getModuleFullTitle (_:t:_) = if True then t else "Module Name is missing or incorrectly formatted"

getModuleCredits :: [String] -> Int
getModuleCredits (_:_:t:_) = if True then read t else 0

getVerifiedModuleCode :: (String-> Bool) -> [String] -> String   -- no validation yet
getVerifiedModuleCode p (t:_) = if p t  then t else "Module heading is missing or incorrectly formatted"


 
    -- case (splitOn "," t) of
    --     (x:_ ) -> if True then x else  "Module heading is missing or incorrectly formatted"
    --     _ ->  "Module heading is missing"

getModuleIndContent :: [String] -> [String]
getModuleIndContent (_:_:t:_)  =   
    case head t of
        '\"' -> if True then splitOn' "\n" $ takeWhile (/= '\"') t else ["Indicative content incorrectly formatted"]
        otherwise -> if True then splitOn' "\n" t else ["Indicative content incorrectly formatted"]
    
    -- case (splitOn' "\n" t) of
    --    xs  -> if True then xs else ["Indicative content incorrectly formatted"]
    --    _ -> ["Indicative content is missing"]
getModuleLearningOutcomes :: [String] -> [String]
getModuleLearningOutcomes (_:_:_:t:_)  =  
    case (splitOn' "\n" t) of
       xs  -> if True then xs else ["Indicative content incorrectly formatted"]
       _ -> ["Module learning outcomes are missing"]
splitOn  :: Char -> String -> [String]
splitOn _ "" = [""]
splitOn  dl (c:cs) = if dl == c then   "" : splitOn  dl cs
                                else  (c:cellCompletion) : otherCells
                                    where cellCompletion : otherCells = splitOn dl  cs

splitOn'  :: String -> String -> [String]   -- check if this is correct - returning empty string following by entire rest of string TODO c
splitOn' _ "" = [""]
splitOn' dl (c:ls:cs) = if startsWith' dl (c:ls:cs)  then  
                                if ls == '\"' then  takeWhile (/= '\"') (cs) : splitOn'  dl (dropWhile (/= '\"') (c:ls:cs))
                                else takeWhile (/= '\"') (ls:cs) : splitOn'  dl (dropWhile (/= '\"') (c:ls:cs))
                                    -- "":   splitOn' dl (ls:cs)-- case ([ls]) of 
                                    --             -- dl -> takeWhile (/= '\"') (cs) : splitOn'  dl (dropWhile (/= '\"') (c:ls:cs))
                                                -- otherwise ->    "" : splitOn'  dl (ls:cs)
                        else  (c:cellCompletion) : otherCells
                                    where cellCompletion : otherCells = splitOn' dl (ls:cs) 


startsWith' :: String -> String -> Bool
startsWith' [] _ = True
startsWith' _ [] = False
startsWith' xs  ys  = xs == take (length xs) ys