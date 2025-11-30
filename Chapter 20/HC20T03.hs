{-# OPTIONS_GHC -Wall #-}

import Control.Monad.Writer (Writer, writer, tell, runWriter)

type Log = [String]
type Calc a = Writer Log a

logStep :: String -> Calc ()
logStep msg = tell [msg] 

add :: Int -> Int -> Calc Int
add x y = do
  let r = x + y
  logStep $ "add " ++ show x ++ " " ++ show y ++ " = " ++ show r
  writer (r, [])

sub :: Int -> Int -> Calc Int
sub x y = do
  let r = x - y
  logStep $ "sub " ++ show x ++ " " ++ show y ++ " = " ++ show r
  writer (r, [])

mul :: Int -> Int -> Calc Int
mul x y = do
  let r = x * y
  logStep $ "mul " ++ show x ++ " " ++ show y ++ " = " ++ show r
  writer (r, [])

divSafe :: Int -> Int -> Calc (Maybe Int)
divSafe _ 0 = do
  logStep "div error: divide by zero"
  writer (Nothing, [])
divSafe x y = do
  let r = x `div` y
  logStep $ "div " ++ show x ++ " " ++ show y ++ " = " ++ show r
  writer (Just r, [])

calcOk :: Calc (Maybe Int)
calcOk = do
  a <- add 10 5
  b <- mul a 3
  divSafe b 5

calcFail :: Calc (Maybe Int)
calcFail = do
  a <- add 8 1
  b <- sub a 3
  _ <- mul b 4
  divSafe b 0

prettyRun :: Show a => Calc a -> IO ()
prettyRun c =
  let (res, logs) = runWriter c
  in do
    putStrLn "---- LOG ----"
    mapM_ putStrLn logs
    putStrLn "---- RESULT ----"
    print res
    putStrLn ""

main :: IO ()
main = do
  putStrLn "Successful run:"
  prettyRun calcOk
  putStrLn "Failing run (divide by zero):"
  prettyRun calcFail
