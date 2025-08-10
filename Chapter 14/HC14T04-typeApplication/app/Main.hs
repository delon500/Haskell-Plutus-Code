{-# LANGUAGE TypeApplications #-}

module Main where

readInt :: String -> Int 
readInt = read @Int

main :: IO ()
main = do 
    print (readInt "123")  
    print (readInt "075")
