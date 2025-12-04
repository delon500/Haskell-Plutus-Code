import Data.Char (toUpper)

-- Reader definition
newtype Reader r a = Reader { runReader :: r -> a }

instance Functor (Reader r) where
  fmap f (Reader ra) = Reader (f . ra)

instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader rab <*> Reader ra = Reader (\r -> rab r (ra r))

instance Monad (Reader r) where
  Reader ra >>= k = Reader $ \r ->
    let a = ra r
    in runReader (k a) r

-- ask: get current environment
ask :: Reader r r
ask = Reader id

-- local: run a Reader under a modified environment
local :: (r -> r) -> Reader r a -> Reader r a
local f (Reader ra) = Reader (ra . f)

-- App config
data Config = Config
  { greetPrefix :: String
  , shout       :: Bool
  } deriving (Show)

-- Helper: build a greeting under the *current* Config
buildGreeting :: String -> Reader Config String
buildGreeting name = do
  cfg <- ask
  let base = greetPrefix cfg ++ " " ++ name
  pure $ if shout cfg then map toUpper base ++ "!" else base

-- Public API: greet; also shows flipping `shout` for a sub-call via `local`
greet :: String -> Reader Config String
greet name = do
  normal <- buildGreeting name
  flipped <- local (\c -> c { shout = not (shout c) }) (buildGreeting name)
  pure (normal ++ "  |  (flipped) " ++ flipped)

-- Demo
main :: IO ()
main = do
  let cfg1 = Config { greetPrefix = "Hello", shout = False }
      cfg2 = Config { greetPrefix = "Howzit", shout = True }

  putStrLn $ runReader (greet "Delon") cfg1
  putStrLn $ runReader (greet "Delon") cfg2
