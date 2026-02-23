module Checks where
import Data.Text as T


checkModuleHeading ::Text  -> Either Text Bool
checkModuleHeading t = undefined
    -- case 
--   case (T.splitOn "\n" t) of
--     (x:xs) -> if (Text.isPrefixOf "module" x) then Right True else Left "Module heading is missing"
--     _ -> Left "Module heading is missing"