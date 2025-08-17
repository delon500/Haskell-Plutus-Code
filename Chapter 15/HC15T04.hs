-- HC15T4: Exception handler for traffic light errors

module Main where

import Control.Exception (Exception, handle, throwIO)
import Data.Char (toLower, isSpace)
import System.IO (hPutStrLn, stderr)

-- Domain
data TrafficLight = Red | Yellow | Green
  deriving (Show, Eq)

data Action = Stop | PrepareToStop | Go
  deriving (Show, Eq)

-- Custom exception
data TrafficLightError = InvalidColor String
  deriving (Show)
instance Exception TrafficLightError

-- Helpers
trim :: String -> String
trim = f . f where f = reverse . dropWhile isSpace

-- Parser that throws our custom exception on bad input
parseTrafficLightIO :: String -> IO TrafficLight
parseTrafficLightIO raw =
  case map toLower (trim raw) of
    "red"    -> pure Red
    "r"      -> pure Red
    "yellow" -> pure Yellow
    "amber"  -> pure Yellow
    "y"      -> pure Yellow
    "green"  -> pure Green
    "g"      -> pure Green
    bad      -> throwIO (InvalidColor bad)

react :: TrafficLight -> Action
react Red    = Stop
react Yellow = PrepareToStop
react Green  = Go

-- ===== The handler function =====
-- If parsing fails, log and choose a safe fallback.
handleTLError :: TrafficLightError -> IO Action
handleTLError (InvalidColor s) = do
  hPutStrLn stderr $ "Traffic light error: invalid color \"" ++ s ++ "\""
  hPutStrLn stderr "Falling back to a safe action: Stop."
  pure Stop

main :: IO ()
main = do
  putStrLn "Enter traffic light color (red / yellow / green):"
  raw <- getLine

  -- Use `handle` with our handler function.
  -- On success: parse then react. On failure: `handleTLError` runs.
  action <- handle handleTLError $ do
    tl <- parseTrafficLightIO raw
    pure (react tl)

  putStrLn $ "Decision: " ++ show action
