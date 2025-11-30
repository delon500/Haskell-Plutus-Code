import Control.Monad.Trans.Maybe (MaybeT(..), runMaybeT)
import Control.Monad.Trans.Class (lift)
import Data.Char (isSpace)
import Text.Read (readMaybe)
import System.IO (hFlush, stdout)


-- Fail in the Maybe layer
failT :: Monad m => MaybeT m a
failT = MaybeT (pure Nothing)

-- Trim spaces
trim :: String -> String
trim = dropWhile isSpace . reverse . dropWhile isSpace . reverse

require :: Monad m => Bool -> MaybeT m ()
require True  = pure ()
require False = failT

-- Ask a line from the user (in the MaybeT IO stack)
askLine :: String -> MaybeT IO String
askLine msg = do
  lift (putStr (msg ++ " ") >> hFlush stdout)
  lift getLine

-- Ask for a non-empty string
askNonEmpty :: String -> MaybeT IO String
askNonEmpty prompt = do
  s <- askLine prompt
  let t = trim s
  require (not (null t))
  pure t

-- Ask for an Int in a range, with parsing and bounds checks
askIntInRange :: String -> Int -> Int -> MaybeT IO Int
askIntInRange prompt lo hi = do
  s <- askLine prompt
  n <- case readMaybe (trim s) :: Maybe Int of
         Nothing -> failT
         Just v  -> pure v
  require (lo <= n && n <= hi)
  pure n

-- Collect a small “profile”, failing early on any invalid input.
collectProfile :: MaybeT IO (String, Int, String)
collectProfile = do
  name <- askNonEmpty "Enter your name:"
  age  <- askIntInRange "Enter your age (1-120):" 1 120
  email <- askNonEmpty "Enter your email:"
  require ('@' `elem` email && '.' `elem` email)
  pure (name, age, email)

main :: IO ()
main = do
  putStrLn "== MaybeT IO: profile collection =="
  result <- runMaybeT collectProfile
  case result of
    Nothing -> putStrLn "Invalid input somewhere. Aborting."
    Just (name, age, email) -> do
      putStrLn "All good! Collected:"
      putStrLn $ "  Name : "  ++ name
      putStrLn $ "  Age  : "  ++ show age
      putStrLn $ "  Email: "  ++ email
