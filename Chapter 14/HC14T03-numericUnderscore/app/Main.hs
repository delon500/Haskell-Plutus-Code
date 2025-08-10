{-# LANGUAGE NumericUnderscores #-}

module Main where

bigInt :: Integer 
bigInt = 1_000_000_000_000_000_000

maxInt32 :: Int 
maxInt32 = 2_147_483_647

piApprox :: Double 
piApprox = 3.141_592_653_589_793

hexWord :: Int
hexWord = 0xDEAD_BEEF

main :: IO ()
main = do
    putStrLn $ "bigInt = " ++ show bigInt
    putStrLn $ "maxInt32 = " ++ show maxInt32
    putStrLn $ "piApprox = " ++ show piApprox
    putStrLn $ "hexWord = " ++ show hexWord
