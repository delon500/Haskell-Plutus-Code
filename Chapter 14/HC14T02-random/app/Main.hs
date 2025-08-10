module Main where
import System.Random (randomRIO)

main :: IO ()
main = do
  putStrLn "Hello, Haskell!"
  n <- randomRIO (1, 100 :: Int)   -- pick Int explicitly
  putStrLn $ "Your random number (1-100): " ++ show n
