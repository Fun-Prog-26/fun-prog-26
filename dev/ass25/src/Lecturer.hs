{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
 


module Lect.Lecturer  where
import Types (ValidationResult(..))
import GHC.Generics (Generic)
import Data.Csv (FromNamedRecord(..), ToNamedRecord, (.:))
import qualified Data.Csv as Csv
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Control.Monad (forM_)
import Data.Char (isDigit, isAlpha)
import Text.Read (readMaybe)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.ByteString as BL



validateId' :: String -> ValidationResult String
validateId' id
  | length id /= 4           = Invalid ["Id must be 4 characters"]
  | not (all isDigit (tail id)) = Invalid ["Id tail must contain digits only"]
  | otherwise                = Valid id

-- Similarly define validateName', validateEmail'

data Lecturer = Lecturer
  { lecturerID   :: !String
  , name          :: !String
  , email         :: !String
  , departmentID  :: !String
  , availableHours      :: !Int
  } deriving (Show, Generic)


instance Csv.FromNamedRecord Lecturer where
  parseNamedRecord  r = Lecturer

    <$> r .: "lecturerID" 
    <*> r .: "name"
    <*> r .: "email"
    <*> r .: "departmentID"
    <*> r .: "availableHours"
    -- return Lecturer {..}

    -- lecturerID     <- T.unpack <$> (m .: "lecturerID" >>= validateLecturerID)
    -- name           <- T.unpack <$> (m .: "name" >>= validateName)
    -- email          <- T.unpack <$> (m .: "email" >>= validateEmail)
    -- departmentID   <- T.unpack <$> (m .: "departmentID" >>= validateDepartmentID)
    -- availableHours <- m .: "availableHours" >>= validateAvailableHours
    -- return Lecturer {..}

instance ToNamedRecord  Lecturer

validateId :: String -> ValidationResult String
validateId id
  | length id /= 4           = Invalid ["Id must be 4 characters"]
  | not (all isDigit (tail id)) = Invalid ["Id tail must contain digits only"]
  | otherwise                = Valid id

validateName :: String -> ValidationResult String
validateName n
  | length n >= 2           = Valid n
  | otherwise                = Invalid ["Name must be at least 2 characters long"]

validateEmail :: String -> ValidationResult String
validateEmail e
  | '@' `elem` e && '.' `elem` (dropWhile (/= '@') e) = Valid e
  | otherwise                = Invalid ["Invalid email format"]

validateDepartmentID :: String -> ValidationResult String
validateDepartmentID did
  | all isAlpha did && not (null did) = Valid did
  | otherwise                = Invalid ["Invalid departmentID"]
-- validateName :: T.Text -> Csv.Parser T.Text
-- validateName n =
--   if T.length n >= 2
--     then return n
--     else fail $ "Name must be at least 2 characters long: " ++ T.unpack n

-- validateEmail :: Text -> Csv.Parser Text
-- validateEmail e =
--   if "@" `T.isInfixOf` e && "." `T.isInfixOf` (T.dropWhile (/= '@') e)
--     then return e
--     else fail $ "Invalid email format: " ++ T.unpack e

-- validateDepartmentID :: Text -> Csv.Parser Text
-- validateDepartmentID did =
--   if T.all isDigit did && not (T.null did)
--     then return did
--     else fail $ "Invalid departmentID: " ++ T.unpack did

-- validateAvailableHours :: Int -> Csv.Parser Int
-- validateAvailableHours ah =
--   if ah >= 0 && ah <= 20
--     then return ah
--     else fail $ "availableHours must be between 0 and 20, but got " ++ show ah