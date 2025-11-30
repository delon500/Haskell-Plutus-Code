{-# OPTIONS_GHC -Wall #-}
module Main where

import Control.Monad.Writer.Strict (Writer, tell, runWriter)
import Data.List (intercalate)

type Log = [String]

logMsg :: String -> Writer Log ()
logMsg = tell . (:[])

logged1 :: (Show a, Show r) => String -> (a -> r) -> a -> Writer Log r
logged1 name f x = do
  logMsg $ "call   " ++ name ++ "(" ++ show x ++ ")"
  let r = f x
  logMsg $ "return " ++ name ++ " -> " ++ show r
  pure r

logged2 :: (Show a, Show b, Show r) => String -> (a -> b -> r) -> a -> b -> Writer Log r
logged2 name f x y = do
  logMsg $ "call   " ++ name ++ "(" ++ show x ++ ", " ++ show y ++ ")"
  let r = f x y
  logMsg $ "return " ++ name ++ " -> " ++ show r
  pure r

squareW :: Int -> Writer Log Int
squareW = logged1 "square" (\x -> x * x)

addW :: Int -> Int -> Writer Log Int
addW = logged2 "add" (+)

mulW :: Int -> Int -> Writer Log Int
mulW = logged2 "mul" (*)

fibW :: Int -> Writer Log Int
fibW n = do
  logMsg $ "call   fib(" ++ show n ++ ")"
  r <- case n of
         0 -> pure 0
         1 -> pure 1
         _ -> do a <- fibW (n-1)
                 b <- fibW (n-2)
                 pure (a + b)
  logMsg $ "return fib -> " ++ show r
  pure r

pipeline :: Writer Log Int
pipeline = do
  a <- addW 2 3
  b <- squareW a
  c <- mulW b 4
  pure c

prettyLog :: Log -> String
prettyLog = intercalate "\n"

main :: IO ()
main = do
  let (res1, log1) = runWriter pipeline
  putStrLn "== Pipeline =="
  putStrLn $ "Result: " ++ show res1
  putStrLn "-- Log --"
  putStrLn $ prettyLog log1

  let (res2, log2) = runWriter (fibW 5)
  putStrLn "\n== fib(5) =="
  putStrLn $ "Result: " ++ show res2
  putStrLn "-- Log --"
  putStrLn $ prettyLog log2
