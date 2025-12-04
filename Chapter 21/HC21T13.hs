newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f (Reader ra) = Reader (f . ra)

instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader rf <*> Reader ra = Reader $ \r -> rf r (ra r)

instance Monad (Reader r) where
  Reader ra >>= k = Reader $ \r -> runReader (k (ra r)) r

ask   :: Reader r r
ask   = Reader id
local :: (r -> r) -> Reader r a -> Reader r a
local f (Reader ra) = Reader (ra . f)

newtype Writer w a = Writer { runWriter :: (a, w) }

instance Functor (Writer w) where
  fmap f (Writer (a,w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  Writer (f,w1) <*> Writer (a,w2) = Writer (f a, w1 <> w2)

instance Monoid w => Monad (Writer w) where
  Writer (a,w1) >>= k =
    let Writer (b,w2) = k a
    in Writer (b, w1 <> w2)

tell :: Monoid w => w -> Writer w ()
tell w = Writer ((), w)

-- ---------- Config + step ----------
data Config = Config { prefix :: String } deriving Show

-- Log one message using the configured prefix
step :: String -> Reader Config (Writer [String] ())
step msg = do
  cfg <- ask
  let line = prefix cfg ++ msg
  pure (tell [line])

-- Compose multiple steps; demonstrate local to tweak prefix
program :: Reader Config (Writer [String] ())
program = do
  a <- step "boot"
  b <- step "check-services"
  c <- local (\cfg -> cfg { prefix = "[SUBSYS] " }) $ step "warmup"
  d <- step "done"
  pure (a >> b >> c >> d)

main :: IO ()
main = do
  let cfg = Config { prefix = "[SYS] " }
      writerAction = runReader program cfg          
      ((), logs)   = runWriter writerAction         
  putStrLn "Logs:"
  mapM_ putStrLn logs
