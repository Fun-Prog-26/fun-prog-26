
module Lib
    ( clean, getHeaderRow, getDataWithoutHeader, getDataWithoutNames, changeToNum
    ,getStudAverages
    ) where

import ModuleData


clean :: String -> [String]

clean d = splitOn  '\n' d   --litOn' "\n" csvData



removePre :: String -> String 
removePre ('\65279':xs) = xs 
removePre xs = xs

getHeaderRow :: String-> String
getHeaderRow  d =   removePre $ head $ splitOn  '\n' d

getDataWithoutHeader:: String -> [String]
getDataWithoutHeader d = tail $ splitOn  '\n' d

getDataWithoutNames :: [String]-> [[String]]
getDataWithoutNames xss =  map (drop 2 . splitOn ',') xss

-- getData :: String -> [[String]]
-- getData xs = getDataWithoutNames $ getDataWithoutHeader xs

changeToNum :: [[String]] -> [[Int]]
changeToNum xss  = map ( map read)  xss

getStudAverages ::  [[Int]] -> [Float]
getStudAverages iss = map getAverage iss

getAverage :: [Int] -> Float
getAverage is = fromIntegral (sum is) / fromIntegral ( length is)