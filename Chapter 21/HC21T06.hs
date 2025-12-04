import Data.Char (toUpper)

newtype Reader r a = Reader { runReader :: r -> a }

-- Functor: map over the result (same env)
instance Functor (Reader r) where
  fmap f (Reader ra) = Reader (f . ra)

-- Applicative: share the same env for function and argument
instance Applicative (Reader r) where
  pure a = Reader (const a)
  Reader rf <*> Reader ra = Reader $ \r -> rf r (ra r)

-- Monad: thread the same env through binds
instance Monad (Reader r) where
  Reader ra >>= k = Reader $ \r -> runReader (k (ra r)) r

-- Helpers
ask  :: Reader r r
ask  = Reader id
asks :: (r -> a) -> Reader r a
asks f = Reader f

data Config = Config
  { prefix :: String
  , suffix :: String
  , shout  :: Bool
  } deriving (Show)

greet :: String -> Reader Config String
greet name = do
  p <- asks prefix
  s <- asks shout
  let base = p ++ " " ++ name
  pure $ if s then map toUpper base ++ "!" else base

signoff :: Reader Config String
signoff = do
  sfx <- asks suffix
  sh  <- asks shout
  pure $ if sh then map toUpper sfx else sfx

composeApp :: String -> Reader Config String
composeApp name =
  (\g s -> g ++ " - " ++ s) <$> greet name <*> signoff

-- Compose the two actions — Monad style
composeMon :: String -> Reader Config String
composeMon name = do
  g <- greet name
  s <- signoff
  pure (g ++ " - " ++ s)

main :: IO ()
main = do
  let cfg1 = Config { prefix = "Hello", suffix = "cheers", shout = False }
      cfg2 = Config { prefix = "Howzit", suffix = "see ya", shout = True  }

  putStrLn "== Applicative composition =="
  putStrLn $ runReader (composeApp "Delon") cfg1
  putStrLn $ runReader (composeApp "Delon") cfg2

  putStrLn "\n== Monad composition =="
  putStrLn $ runReader (composeMon "Delon") cfg1
  putStrLn $ runReader (composeMon "Delon") cfg2
