module Split.LibSplit where
import Data.List.Split (splitOn)  -- from package split - split needs to go into dependencies in package.yaml

splitOnSpace ::  [String]
splitOnSpace  =  splitOn " " "hello there MAIREAD" 

splitOnSpaceWithInput :: String->   [String]
splitOnSpaceWithInput input = splitOn " " input
