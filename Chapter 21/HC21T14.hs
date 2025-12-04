newtype Writer w a = Writer { runWriter :: (a, w) }

instance Functor (Writer w) where
  fmap f (Writer (a,w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  Writer (f,w1) <*> Writer (a,w2) = Writer (f a, w1 <> w2)

instance Monoid w => Monad (Writer w) where
  Writer (a,w1) >>= k = let Writer (b,w2) = k a in Writer (b, w1 <> w2)

tell :: Monoid w => w -> Writer w ()
tell w = Writer ((), w)

newtype State s a = MkState { runState :: s -> (a, s) }

instance Functor (State s) where
  fmap f (MkState sa) = MkState $ \s -> let (a,s') = sa s in (f a, s')

instance Applicative (State s) where
  pure a = MkState $ \s -> (a, s)
  MkState sf <*> MkState sa = MkState $ \s ->
    let (f,s1) = sf s
        (a,s2) = sa s1
    in (f a, s2)

instance Monad (State s) where
  MkState sa >>= k = MkState $ \s ->
    let (a,s1)    = sa s
        MkState b = k a
    in b s1

get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

inc :: Int -> State Int (Writer [String] ())
inc n = MkState $ \s ->
  let s' = s + n
  in ( tell ["inc +" ++ show n ++ " -> " ++ show s']
     , s'
     )

dec :: Int -> State Int (Writer [String] ())
dec n = MkState $ \s ->
  let s' = s - n
  in ( tell ["dec -" ++ show n ++ " -> " ++ show s']
     , s'
     )

program :: State Int (Writer [String] ())
program = do
  w1 <- inc 3
  w2 <- dec 1
  w3 <- inc 10
  pure (w1 >> w2 >> w3)  

main :: IO ()
main = do
  let start = 0
      (w, finalState) = runState program start
      ((), logs)      = runWriter w
  putStrLn $ "Final state: " ++ show finalState
  putStrLn   "Logs:"
  mapM_ putStrLn logs

{-
When we choose State s (Writer w a), the primary effect is state mutation, 
and logging becomes a secondary return value. Each state-changing operation 
must manually return a Writer, and the caller must manually combine logs 
(e.g. w1 >> w2 >> w3). This makes logging feel bolted-on and requires extra 
plumbing.

If we flip the order to Writer w (State s a), we instead build a stateful 
program as data while producing logs during its construction. 
This is elegant when logging is about program description, 
but awkward when logging should happen as effects occur, 
since you still need to runWriter first and then separately 
run the state computation.

In practice, neither ordering is ideal for real programs. 
The ergonomic solution is to use a monad transformer, 
such as StateT s (Writer w) a, so both modify and tell 
live in the same monad. This allows clean code where state 
updates and logging interleave naturally without extra 
wrapping or manual composition giving you the benefits 
of both effects without the awkwardness of nesting.
-}

