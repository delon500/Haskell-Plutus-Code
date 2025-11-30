import Control.Monad.State.Strict
import qualified Data.Map.Strict as M

type Cache = M.Map Int Integer

fibM :: Int -> State Cache Integer
fibM n
  | n < 0     = error "fibonacci: negative input"
  | n == 0    = pure 0
  | n == 1    = pure 1
  | otherwise = do
      cache <- get
      case M.lookup n cache of
        Just v  -> pure v
        Nothing -> do
          a <- fibM (n - 1)
          b <- fibM (n - 2)
          let v = a + b
          modify' (M.insert n v)
          pure v

fibonacciMemo :: Int -> Integer
fibonacciMemo n =
  evalState (fibM n) (M.fromList [(0,0),(1,1)])

main :: IO ()
main = do
  print $ fibonacciMemo 0    -- 0
  print $ fibonacciMemo 1    -- 1
  print $ fibonacciMemo 10   -- 55
  print $ fibonacciMemo 40   -- 102334155