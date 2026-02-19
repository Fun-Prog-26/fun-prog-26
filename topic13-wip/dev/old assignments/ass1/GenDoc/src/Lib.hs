module Lib

where
    f x = x
--     ( clean, getHeaderRow, getDataWithoutHeader, getDataWithoutNames, changeToNum
--     ,getStudAverages
--     ) where
-- import qualified  Data.List.Split as S


-- clean :: String -> [String]

-- clean d = map removePre (S.splitOn  "\r\n" d)

-- removePre :: String -> String 
-- removePre ('\65279':xs) = xs 
-- removePre xs = xs

-- getHeaderRow :: String-> String
-- getHeaderRow  d =   removePre $ head $ S.splitOn  "\r\n" d

-- getDataWithoutHeader:: String -> [String]
-- getDataWithoutHeader d = tail $ S.splitOn  "\r\n" d

-- getDataWithoutNames :: [String]-> [[String]]
-- getDataWithoutNames xss =  map (drop 2 . S.splitOn ",") xss

-- -- getData :: String -> [[String]]
-- -- getData xs = getDataWithoutNames $ getDataWithoutHeader xs

-- changeToNum :: [[String]] -> [[Int]]
-- changeToNum xss  = map ( map read)  xss

-- getStudAverages ::  [[Int]] -> [Float]
-- getStudAverages iss = map getAverage iss

-- getAverage :: [Int] -> Float
-- getAverage is = fromIntegral (sum is) / fromIntegral ( length is)