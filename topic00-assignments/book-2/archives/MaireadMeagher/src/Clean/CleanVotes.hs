module Clean.CleanVotes where

import Text.Read
import Data.List.Split (splitOn)




changeToInt :: [String] -> [Int]
changeToInt = map (\x -> read x::Int )

--put in types here
getStudentNames csvData = map (head  . tail . splitOn",") $ tail $ splitOn "\r\n" csvData

getMarks csvData = map ( changeToInt . drop 2 . splitOn ",")  $ tail $ splitOn "\r\n" csvData

getStudAndMarks csvData= zip (getStudentNames  csvData ) (getMarks  csvData)

getStudAvgMarks csvData= zip (getStudentNames csvData)  (map (\x-> sum x `div` length x ) (getMarks csvData ) )

getModuleNames csvData = splitOn "," $drop 3 (head (splitOn "\r\n" csvData))
  