
module Lib
    ( makeTitle
    ) where
import qualified Data.Text as T
-- makeAnagram ::Text -> Text
-- makeAnagram  ts =   map takeFirstLetter  makeWords ts

-- makeWords :: Text -> [Text]
-- makeWords xs 

-- sentence = T.pack "hello world"
makeTitle :: T.Text -> T.Text
makeTitle  = T.toTitle 
