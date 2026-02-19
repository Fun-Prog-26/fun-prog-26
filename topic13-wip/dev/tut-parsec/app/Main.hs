module Main (main) where

import VersionNumberParser
import SrtFileParser

import Text.ParserCombinators.ReadP
import Data.Char
import Data.Maybe
import System.IO

-- main
--   ::  IO ()
-- main
--   = do
--   putStrLn "What is the version output file path?"
--   filePath   <- getLine
--   text       <- readFile filePath
--   let result =
--         case readP_to_S (parseVersionNumber []) text of
--           []      -> []
--           r@(_:_) -> map readInt $ fst $ last r
--   putStrLn ""
--   print result


main
  ::  IO ()
main
  = do
  putStrLn "What is the SRT file path?"
  filePath   <- getLine
  text       <- readFile filePath
  let result =
        case readP_to_S parseSrt text of
          []      -> []
          r@(_:_) -> fst $ last r
  putStrLn ""
  print result
