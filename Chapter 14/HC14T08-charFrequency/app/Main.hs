module Main where

import Data.List (sort, group)

counts :: String -> [(Char, Int)]
counts = map (\g -> (head g, length g)) . group . sort

main :: IO ()
main = do 
    putStrLn "Enter Text: "
    text <- getLine
    print (counts text) 
