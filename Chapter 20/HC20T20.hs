{-# OPTIONS_GHC -Wall #-}
module Main where

batchProcessing :: Monad m => [m a] -> m [a]
batchProcessing =
  foldr
    (\mx acc ->
        mx >>= \x ->
        acc >>= \xs ->
        pure (x : xs))
    (pure [])

ioDemo :: IO ()
ioDemo = do
  putStrLn "Enter two words:"
  xs <- batchProcessing [getLine, getLine]
  putStrLn $ "You entered: " ++ show xs

-- Maybe demo: succeeds only if all are Just
maybeDemo :: IO ()
maybeDemo = do
  print (batchProcessing [Just 1, Just 2, Just 3]       :: Maybe [Int])  
  print (batchProcessing [Just 1, Nothing, Just 3]      :: Maybe [Int])  

-- Either demo: short-circuits on the first Left
eitherDemo :: IO ()
eitherDemo = do
  let a = batchProcessing [Right 10, Right 20, Right 30]        :: Either String [Int]
      b = batchProcessing [Right 10, Left "boom", Right 30]     :: Either String [Int]
  print a   -- Right [10,20,30]
  print b   -- Left "boom"

main :: IO ()
main = do
  ioDemo
  maybeDemo
  eitherDemo
