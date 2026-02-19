module ModuleData where
import Data.Text


data Module = Module {
    moduleCode :: Text,
    moduleFullTitle :: Text,
    moduleIndContent :: [Text],
    moduleLearningOutcomes :: [Text]

} deriving (Show, Eq)

