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

-- Helpers
get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

nextSeed :: Int -> Int
nextSeed s =
  let a = 1103515245
      c = 12345
      m = 2147483647  
  in (a * s + c) `mod` m

type RWState = (Int, (Int,Int))

-- Read current position without changing state
position :: State RWState (Int,Int)
position = MkState $ \st@(_, pos) -> (pos, st)

randomStep :: State RWState ()
randomStep = do
  (s, (x,y)) <- get
  let s' = nextSeed s
      dir = s' `mod` 4  -- 0=U, 1=D, 2=L, 3=R
      (x', y') = case dir of
                   0 -> (x    , y + 1) -- Up
                   1 -> (x    , y - 1) -- Down
                   2 -> (x - 1, y    ) -- Left
                   _ -> (x + 1, y    ) -- Right
  put (s', (x', y'))

randomWalk :: Int -> State RWState [(Int,Int)]
randomWalk n
  | n <= 0    = (:[]) <$> position
  | otherwise = do
      p  <- position
      randomStep
      ps <- randomWalk (n - 1)
      pure (p : ps)

main :: IO ()
main = do
  let startSeed  = 42
      startPos   = (0,0)
      steps      = 10
      startState = (startSeed, startPos)
      (path, endState) = runState (randomWalk steps) startState

  putStrLn $ "Start state : " ++ show startState
  putStrLn $ "Path (" ++ show (length path) ++ " points): " ++ show path
  putStrLn $ "End state   : " ++ show endState
