

module Shuffle where 

    import System.Random

    shuffle :: [a] -> IO [a]
    shuffle [] = return []
    shuffle xs = do
        i <- randomRIO (0, length xs - 1)
        let (front,(a:back)) = splitAt i xs
        rest <- shuffle (front ++ back)
        return (a : rest)