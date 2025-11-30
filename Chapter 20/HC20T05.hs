{-# OPTIONS_GHC -Wall #-}

import Control.Monad.Reader
import Data.Char (toUpper)

-- App config
data Config = Config
  { greetingPrefix :: String   
  , punctuation    :: String   
  , capitalize     :: Bool
  } deriving (Show)

-- Helper: maybe capitalize the first letter
capFirst :: String -> String
capFirst []     = []
capFirst (c:cs) = toUpper c : cs

greetUser :: String -> Reader Config String
greetUser name = do
  cfg <- ask
  let nm  = if capitalize cfg then capFirst name else name
  pure $ greetingPrefix cfg ++ " " ++ nm ++ punctuation cfg

greetUser' :: String -> Reader Config String
greetUser' name = do
  pref <- asks greetingPrefix
  punc <- asks punctuation
  cap  <- asks capitalize
  let nm = if cap then capFirst name else name
  pure (pref ++ " " ++ nm ++ punc)

greetLoud :: String -> Reader Config String
greetLoud name = local (\c -> c { punctuation = "!!!" }) (greetUser name)

-- Demo
main :: IO ()
main = do
  let cfg = Config { greetingPrefix = "Hello", punctuation = "!", capitalize = True }

  putStrLn $ runReader (greetUser  "neo") cfg        
  putStrLn $ runReader (greetUser' "james")   cfg        
  putStrLn $ runReader (greetLoud  "carlton") cfg        

  putStrLn $ runReader
    (local (\c -> c { greetingPrefix = "Sawubona", capitalize = False })
           (greetUser "thabo"))
    cfg

