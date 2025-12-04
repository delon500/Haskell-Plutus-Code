{-# OPTIONS_GHC -Wall #-}
-- State core
newtype State s a = MkState { runState :: s -> (a, s) }

-- Functor: map over the produced value, thread state unchanged
instance Functor (State s) where
  fmap f (MkState sa) = MkState $ \s ->
    let (a, s') = sa s
    in (f a, s')

-- Applicative: pure returns value without touching state; <*> threads state
instance Applicative (State s) where
  pure a = MkState $ \s -> (a, s)
  MkState sf <*> MkState sa = MkState $ \s ->
    let (f, s1) = sf s
        (a, s2) = sa s1
    in (f a, s2)

-- Monad: >>= feeds the value to k and threads the updated state
instance Monad (State s) where
  MkState sa >>= k = MkState $ \s ->
    let (a, s1)        = sa s
        MkState sb     = k a
        (b, s2)        = sb s1
    in (b, s2)

-- Primitives
get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = MkState $ \s -> ((), f s)

-- Example: bump a counter and read it
bumpTwice :: State Int Int
bumpTwice = do
  modify (+1)
  put 10
  get  

main :: IO ()
main = do
  let (result, finalState) = runState bumpTwice 0
  putStrLn $ "result = " ++ show result      
  putStrLn $ "final  = " ++ show finalState
