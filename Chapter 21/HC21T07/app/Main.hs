module Main where

import qualified Data.Map.Strict as M

-- Store everything as text
type Env = M.Map String String

lookupDefault :: String -> String -> Env -> String
lookupDefault key def env = M.findWithDefault def key env

getDbHostP :: Env -> String
getDbHostP env = lookupDefault "DB_HOST" "localhost" env

getDbPortP :: Env -> String
getDbPortP env = lookupDefault "DB_PORT" "5432" env

getDbUserP :: Env -> String
getDbUserP env = lookupDefault "DB_USER" "postgres" env

connStringP :: Env -> String
connStringP env =
  "host=" ++ getDbHostP env
  ++ " port=" ++ getDbPortP env
  ++ " user=" ++ getDbUserP env

-- Reader
newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f (Reader g) = Reader (f . g)

instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader rf <*> Reader ra = Reader $ \r -> rf r (ra r)

instance Monad (Reader r) where
  Reader ra >>= k = Reader $ \r -> runReader (k (ra r)) r

ask  :: Reader r r
ask  = Reader id
asks :: (r -> a) -> Reader r a
asks f = Reader f

local :: (r -> r) -> Reader r a -> Reader r a
local f (Reader ra) = Reader (ra . f)

-- Reader-based versions
getDbHost, getDbPort, getDbUser :: Reader Env String
getDbHost = asks (lookupDefault "DB_HOST" "localhost")
getDbPort = asks (lookupDefault "DB_PORT" "5432")
getDbUser = asks (lookupDefault "DB_USER" "postgres")

connString :: Reader Env String
connString = do
  h <- getDbHost
  p <- getDbPort
  u <- getDbUser
  pure $ "host=" ++ h ++ " port=" ++ p ++ " user=" ++ u

-- Override just DB_PORT in a sub-computation
connStringOverridePort :: Reader Env String
connStringOverridePort =
  local (M.insert "DB_PORT" "15432") connString

main :: IO ()
main = do
  let baseEnv :: Env
      baseEnv = M.fromList
        [ ("DB_HOST","db.internal")
        , ("DB_PORT","5432")
        , ("DB_USER","readonly")
        ]

  putStrLn "== Plain (explicit Env) =="
  putStrLn $ connStringP baseEnv

  putStrLn "\n== Reader (same env) =="
  putStrLn $ runReader connString baseEnv

  putStrLn "\n== Reader with local (override DB_PORT only) =="
  putStrLn $ runReader connStringOverridePort baseEnv

  putStrLn "\n== Using ask to show current env size =="
  let envSize :: Reader Env Int
      envSize = do e <- ask; pure (M.size e)
  print $ runReader envSize baseEnv
