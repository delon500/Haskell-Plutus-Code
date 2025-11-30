{-# OPTIONS_GHC -Wall #-}

import Control.Exception (try, throwIO, SomeException)
import Control.Concurrent (threadDelay)
import Data.IORef (newIORef, readIORef, writeIORef)

retryIO :: Int -> IO a -> IO a
retryIO n action
  | n <= 0    = error "retryIO: number of attempts must be positive"
  | otherwise = go n
  where
    go k = do
      r <- try @SomeException action
      case r of
        Right v -> pure v
        Left  e -> if k <= 1 then throwIO e else go (k - 1)

retryIODelay :: Int -> Int -> IO a -> IO a
retryIODelay n delayMicros action
  | n <= 0    = error "retryIODelay: number of attempts must be positive"
  | otherwise = go n
  where
    go k = do
      r <- try @SomeException action
      case r of
        Right v -> pure v
        Left  e -> if k <= 1
                    then throwIO e
                    else threadDelay delayMicros >> go (k - 1)

makeFlaky :: IO (IO String)
makeFlaky = do
  ref <- newIORef (0 :: Int)
  pure $ do
    c <- readIORef ref
    if c < 2
      then writeIORef ref (c + 1) >> throwIO (userError ("flaky fail #" <> show (c + 1)))
      else pure "Success on third try!"

main :: IO ()
main = do
  putStrLn "=== retryIO demo ==="
  flaky <- makeFlaky
  msg1  <- retryIO 3 flaky
  putStrLn msg1

  putStrLn "\n=== retryIODelay demo (200ms between tries) ==="
  flaky2 <- makeFlaky
  msg2   <- retryIODelay 3 200000 flaky2  
  putStrLn msg2
