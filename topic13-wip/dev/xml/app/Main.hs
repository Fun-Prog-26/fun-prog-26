{-# LANGUAGE OverloadedStrings #-}

import qualified Text.XML as XML
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Data.Maybe (mapMaybe)

main :: IO ()
main = do
    doc <- XML.readFile XML.def "example.xml"

    let root = XML.documentRoot doc
        studentElements = onlyElements (XML.elementNodes root)

    mapM_ printStudentName studentElements


-- Print the <name> inside a <student>
printStudentName :: XML.Element -> IO ()
printStudentName student = do
    let nameElements =
            filter isIdElement
                   (onlyElements (XML.elementNodes student))

    mapM_ (printNameContent) nameElements


-- Extract and print text content
printNameContent :: XML.Element -> IO ()
printNameContent el =
    case mapMaybe nodeToText (XML.elementNodes el) of
      (txt:_) -> TIO.putStrLn txt
      []      -> pure ()


-- Helpers

onlyElements :: [XML.Node] -> [XML.Element]
onlyElements = mapMaybe nodeToElement

nodeToElement :: XML.Node -> Maybe XML.Element
nodeToElement (XML.NodeElement e) = Just e
nodeToElement _                   = Nothing

nodeToText :: XML.Node -> Maybe T.Text
nodeToText (XML.NodeContent t) = Just t
nodeToText _                   = Nothing

isNameElement :: XML.Element -> Bool
isNameElement el =
    XML.nameLocalName (XML.elementName el) == "name"

isIdElement :: XML.Element -> Bool
isIdElement el =
    XML.nameLocalName (XML.elementName el) == "id"
