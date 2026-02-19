
{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text)
import qualified Data.Text as T

main :: IO ()
main = do
    let message :: Text
        message = "Hello, Stack!"
    putStrLn $ "Original: " ++ T.unpack message
    putStrLn $ "Uppercase: " ++ T.unpack (T.toUpper message)
    putStrLn $ "Lowercase: " ++ T.unpack (T.toLower message)