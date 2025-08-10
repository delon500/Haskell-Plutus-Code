{-# LANGUAGE PartialTypeSignatures #-}
{-# OPTIONS_GHC -Wno-partial-type-signatures #-}

module Main where

square :: _ -> _ 
square x = x * x

sumDouble :: _ -> _ 
sumDouble = sum . map (*2)

main :: IO ()
main = do 
    print (square 5)
    print (square 3.5)
    print (sumDouble [1, 2, 3, 4, 5])
