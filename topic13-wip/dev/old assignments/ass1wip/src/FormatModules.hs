module FormatModules where

    import ModuleParser
    import Data.Text (Text)
    import qualified Data.Text as T


    formatModule :: ModuleModel -> String
    formatModule (ModuleModel code title credits level content outcomes) = 
        "Module Code: " ++ T.unpack code ++ "\n" ++
        "Module Title: " ++ T.unpack title ++ "\n" ++
        "Module Credits: " ++ show credits ++ "\n" ++
        "Module Level: " ++ T.unpack level ++ "\n" ++
        "Module Content: " ++ show content ++ "\n" ++
        "Module Learning Outcomes: " ++ show outcomes ++ "\n" ++
        "*************************************************\n"