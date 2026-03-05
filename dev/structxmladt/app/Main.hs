{-# LANGUAGE OverloadedStrings #-}
module Main (main) where
import qualified Data.Text as T
import qualified Text.XML as X
import Text.XML.Cursor
import Parse
import Render


main :: IO ()
main = do
  let inFile  = "iteration-loops-15q.xml"
  let outFile = "iteration-loops-15q.md"

  doc <- X.readFile X.def inFile
  let root = fromDocument doc

  case parseQuiz root of
    Left err -> error err
    Right quiz -> do
      let md = renderQuiz quiz
      writeFile outFile (T.unpack md)
      putStrLn ("Wrote: " <> outFile)