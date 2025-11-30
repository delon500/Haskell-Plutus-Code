{-# OPTIONS_GHC -Wall #-}

import Control.Monad.Trans.Class      (lift)
import Control.Monad.Trans.State.Strict (StateT, runStateT, get, put, modify')
import Control.Monad.Trans.Maybe        (MaybeT(..), runMaybeT)
import Data.Functor.Identity            (Identity(..))

type App = StateT Int (MaybeT Identity)

runApp :: App a -> Int -> Maybe (a, Int)
runApp app s0 = runIdentity (runMaybeT (runStateT app s0))

abort :: App a
abort = lift (MaybeT (pure Nothing))

deposit :: Int -> App ()
deposit n = modify' (+ n)

withdraw :: Int -> App ()
withdraw n = do
  bal <- get
  if n <= bal
     then put (bal - n)
     else abort  

programOk :: App Int
programOk = do
  deposit 50
  withdraw 20
  deposit 5
  get  -- return final balance

programFail :: App Int
programFail = do
  deposit 10
  withdraw 7
  withdraw 10   -- will exceed balance -> abort (Nothing)
  get

pretty :: Show a => Maybe (a, Int) -> String
pretty (Just (val, bal)) = "Success: value=" ++ show val ++ ", balance=" ++ show bal
pretty Nothing           = "Failure (Nothing): aborted due to rule violation"

main :: IO ()
main = do
  putStrLn "=== Nested StateT + MaybeT demo ==="
  putStrLn $ "programOk  with start=0   -> " ++ pretty (runApp programOk   0)
  putStrLn $ "programFail with start=0  -> " ++ pretty (runApp programFail 0)
