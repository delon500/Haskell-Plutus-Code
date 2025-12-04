newtype Writer w a = Writer { runWriter :: (a, w) }
  deriving Show

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

--------------------------------------------------
-- Reader Config
--------------------------------------------------

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

local :: (r -> r) -> Reader r a -> Reader r a
local f (Reader ra) = Reader (ra . f)

--------------------------------------------------
-- Config for Reader
--------------------------------------------------

data Config = Config
  { prefix :: String
  } deriving Show

--------------------------------------------------
-- 1) Writer associativity law
--    (m >>= k) >>= h == m >>= (\x -> k x >>= h)
--------------------------------------------------

mW :: Writer [String] Int
mW = do
  tell ["start m"]
  pure 10

k :: Int -> Writer [String] String
k x = do
  tell ["in k with " ++ show x]
  pure ("k(" ++ show x ++ ")")

h :: String -> Writer [String] Bool
h s = do
  tell ["in h with " ++ s]
  pure (length s > 0)

testWriterAssoc :: IO ()
testWriterAssoc = do
  let left  = (mW >>= k) >>= h
      right = mW >>= (\x -> k x >>= h)

  putStrLn "=== Writer associativity test ==="
  putStrLn $ "left  = " ++ show (runWriter left)
  putStrLn $ "right = " ++ show (runWriter right)
  putStrLn $ "Equal? " ++ show (runWriter left == runWriter right)
  putStrLn ""

--------------------------------------------------
-- 2) Reader laws with local and ask
--
-- (a) local id m == m
-- (b) local f (ask >>= k) == ask >>= (\r -> local f (k (f r)))
--------------------------------------------------

-- simple Reader action that uses prefix from Config
greet :: String -> Reader Config String
greet name = do
  cfg <- ask
  pure (prefix cfg ++ name)

-- For law (a): local id m == m
testReaderLocalId :: IO ()
testReaderLocalId = do
  let cfg = Config "[CFG] "
      m   = greet "Delon"

      left  = runReader (local id m) cfg
      right = runReader m cfg

  putStrLn "=== Reader law (local id m == m) ==="
  putStrLn $ "left  = " ++ show left
  putStrLn $ "right = " ++ show right
  putStrLn $ "Equal? " ++ show (left == right)
  putStrLn ""

-- For law (b):
-- local f (ask >>= k) == ask >>= (\r -> local f (k (f r)))
--
-- we choose some f and k:
fCfg :: Config -> Config
fCfg c = c { prefix = "[OVERRIDE] " ++ prefix c }

kCfg :: Config -> Reader Config String
kCfg c = greet ("user@" ++ prefix c)

testReaderLocalAskLaw :: IO ()
testReaderLocalAskLaw = do
  let cfg = Config "[CFG] "

      leftReader  = local fCfg (ask >>= kCfg)
      rightReader = ask >>= (\r -> local fCfg (kCfg (fCfg r)))

      left  = runReader leftReader cfg
      right = runReader rightReader cfg

  putStrLn "=== Reader law with local & ask ==="
  putStrLn "Law: local f (ask >>= k) == ask >>= (\\r -> local f (k (f r)))"
  putStrLn $ "left  = " ++ show left
  putStrLn $ "right = " ++ show right
  putStrLn $ "Equal? " ++ show (left == right)
  putStrLn ""

main :: IO ()
main = do
  testWriterAssoc
  testReaderLocalId
  testReaderLocalAskLaw
