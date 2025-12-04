newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f (Reader ra) = Reader (f . ra)

instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader rf <*> Reader ra = Reader $ \r -> rf r (ra r)

instance Monad (Reader r) where
  Reader ra >>= k = Reader $ \r ->
    runReader (k (ra r)) r

ask :: Reader r r
ask = Reader id

newtype State s a = MkState { runState :: s -> (a, s) }

instance Functor (State s) where
  fmap f (MkState sa) = MkState $ \s ->
    let (a,s') = sa s
    in (f a, s')

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

modify :: (s -> s) -> State s ()
modify f = MkState $ \s -> ((), f s)

data Config = Config
  { threshold :: Int
  } deriving (Show)

tick :: Reader Config (State Int Bool)
tick = do
  cfg <- ask
  pure $ do
    modify (+1)
    n <- get
    pure (n >= threshold cfg)

-- Run N ticks under a given config and initial counter
runTicks :: Int -> Config -> Int -> ([Bool], Int)
runTicks n cfg initCount =
  let step :: State Int Bool
      step = runReader tick cfg
      go  :: Int -> Int -> [Bool] -> ([Bool], Int)
      go 0 s acc = (reverse acc, s)
      go k s acc =
        let (b, s') = runState step s
        in go (k - 1) s' (b : acc)
  in go n initCount []

main :: IO ()
main = do
  let cfgLow    = Config { threshold = 3 }
      cfgHigh   = Config { threshold = 5 }
      steps     = 6
      start     = 0

      (ticksLow , finalLow ) = runTicks steps cfgLow  start
      (ticksHigh, finalHigh) = runTicks steps cfgHigh start

  putStrLn "== Config 1: threshold = 3 =="
  putStrLn $ "Ticks result : " ++ show ticksLow
  putStrLn $ "Final counter: " ++ show finalLow

  putStrLn "\n== Config 2: threshold = 5 =="
  putStrLn $ "Ticks result : " ++ show ticksHigh
  putStrLn $ "Final counter: " ++ show finalHigh
