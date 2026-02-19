import Data.ByteString (intercalate)
split :: Eq a => a -> [a] -> [[a]]
split c [] = []
split c xs = xs' : if null xs'' then [] else split c (tail xs'')
    where xs' = takeWhile (/=c) xs
          xs''= dropWhile (/=c) xs

examples :: [(Char, String)]
examples = [('@',"pbv@dcc.fc.up.pt"), ('/',"/usr/include"), ('*', "data*txt")]

test :: (Show a, Eq a) => (a, [a]) -> String
test (c,xs) = unwords ["split", show c, show xs, "=", show ys]
    where ys = split c xs
   
otherMain :: IO ()  -- this does not use mapM_ so we just see how it just prints one (the head element)
otherMain = putStrLn $ head $ map test examples

main :: IO ()  -- this uses mapM_ which maps an action (putStrLn.show ) across examples - a better option
main = mapM_ (putStrLn.test) examples

mainWithResultType :: IO [()]
mainWithResultType = mapM (putStrLn.test) examples

makeInt :: String -> Int
makeInt xs = read xs

newMain = putStrLn $ unwords ["1","2"]