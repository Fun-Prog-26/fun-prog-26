module Main where

import Lib
import Clean.CleanVotes 

main :: IO ()
main = do
     csvData <-  readFile "data.csv"
    --  let firstClean = splitOn "\r\n" csvData
  
    --  let studentNames = map (head  . tail . splitOn",") $ tail firstClean
    --  let moduleNames = splitOn "," $drop 3 (head firstClean)
    --  let marks = map ( changeToInt . drop 2 . splitOn ",")  $ tail $ splitOn "\r\n" csvData
     print "Student Names : " 
     print $ getStudentNames csvData
     print "Module Names : "
     print $getModuleNames csvData
     print "Marks "
     print $ getMarks csvData 
     print "Student Names with marks" 
 
     print $ getStudAndMarks csvData
     print "Student names with average marks"
     print $ getStudAvgMarks csvData

