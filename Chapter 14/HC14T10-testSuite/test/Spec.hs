module Main (main) where 

import CharCounts (counts)
import System.Exit (exitFailure, exitSuccess)

assertEqual :: (Eq a, Show a) => String -> a -> a -> IO Bool 
assertEqual label expected actual = 
    if expected == actual 
        then pure True
        else do 
            putStrLn ("FAIL: " ++ label)
            putStrLn ("  expected: " ++ show expected)
            putStrLn ("  actual  : " ++ show actual)
            pure False

main :: IO ()
main = do
  ok1 <- assertEqual "empty"           []                                     (counts "")
  ok2 <- assertEqual "mississippi"     [('i',4),('m',1),('p',2),('s',4)]      (counts "mississippi")
  ok3 <- assertEqual "case-sensitive"  [('A',2),('a',2)]                      (counts "aaAA")
  let xs = "abbaac"
  ok4 <- assertEqual "sum matches len" (length xs) (sum (map snd (counts xs)))
  if and [ok1, ok2, ok3, ok4] then exitSuccess else exitFailure