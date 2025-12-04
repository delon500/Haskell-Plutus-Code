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

-- Primitives
get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = MkState $ \s -> ((), f s)

-- ========== Undo stack over (current, history) ==========

-- Push old current into history, set new current
setValue :: Int -> State (Int,[Int]) ()
setValue new = modify $ \(cur, hist) -> (new, cur:hist)

-- Pop: restore last from history if present (no-op if empty)
undo :: State (Int,[Int]) ()
undo = modify $ \(cur, hist) ->
  case hist of
    (h:hs) -> (h, hs)
    []     -> (cur, [])

-- Demo script: several sets and undos; return final value and history
script :: State (Int,[Int]) (Int,[Int])
script = do
  setValue 5       -- (5,  [0])
  setValue 9       -- (9,  [5,0])
  setValue (-1)    -- (-1, [9,5,0])
  undo             -- (9,  [5,0])
  undo             -- (5,  [0])
  setValue 42      -- (42, [5,0])
  undo             -- (5,  [0])
  get              -- return (current, history)

main :: IO ()
main = do
  let startState = (0, [])                 -- current = 0, history = []
      (final, endState) = runState script startState
  putStrLn $ "Final (returned): " ++ show final
  putStrLn $ "End state       : " ++ show endState