module Main (main) where

import Duplicates

-- Import necessary modules

-- Main function
main :: IO ()
main = do
    -- Define a sample list with duplicates
    let sampleList = [1, 2, 3, 1, 2, 4, 5, 3, 6]

    -- Remove duplicates from the sample list
    let uniqueList = undefined -- TODO: Call the removeDuplicates function from the Words module

    -- Print the unique list
    putStrLn $ "List with duplicates removed: " ++ show uniqueList
