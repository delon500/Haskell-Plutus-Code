import Data.Monoid (Monoid(..))
import Data.Char   (toLower)
import Data.List   (isInfixOf)

-- Custom Writer storing (result, log)
newtype Writer w a = Writer { runWriter :: (a, w) }

-- Instances
instance Functor (Writer w) where
  fmap f (Writer (a, w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  Writer (f, w1) <*> Writer (a, w2) = Writer (f a, w1 <> w2)

instance Monoid w => Monad (Writer w) where
  Writer (a, w1) >>= k =
    let Writer (b, w2) = k a
    in Writer (b, w1 <> w2)

-- Basic helper
tell :: Monoid w => w -> Writer w ()
tell w = Writer ((), w)

-- listen: expose current log alongside the value (and keep the log)
listen :: Monoid w => Writer w a -> Writer w (a, w)
listen (Writer (a, w)) = Writer ((a, w), w)

-- pass: post-process the current log with a function carried in the value
-- Input carries (value, logTransformer); we apply transformer to accumulated log.
pass :: Monoid w => Writer w (a, w -> w) -> Writer w a
pass (Writer ((a, tweak), w)) = Writer (a, tweak w)

-- ===== Demo: redact any log line containing "secret" (case-insensitive) =====

type Log = [String]

logMsg :: String -> Writer Log ()
logMsg msg = tell [msg]

lower :: String -> String
lower = map toLower

containsSecret :: String -> Bool
containsSecret s = "secret" `isInfixOf` lower s

-- Transform: replace any line containing "secret" with "[REDACTED]"
redactSecrets :: Log -> Log
redactSecrets = map (\ln -> if containsSecret ln then "[REDACTED]" else ln)

-- Some computation that logs a few lines
workflow :: Writer Log Int
workflow = do
  logMsg "starting job"
  logMsg "loading config"
  logMsg "secret api key = ABC-123"
  logMsg "doing work..."
  pure 42

-- Show how listen/pass work together:
-- 1) listen to peek at the original log during the computation
-- 2) attach a transformer (redactSecrets) and pass it to rewrite the final log
demo :: Writer Log Int
demo = pass $ do
  (val, originalLog) <- listen workflow
  -- We can still log after listening (this goes into the same log 'w'):
  logMsg ("peeked " ++ show (length originalLog) ++ " lines")
  -- Return (value, transformer) for 'pass' to apply on the *whole* accumulated log
  pure (val, redactSecrets)

main :: IO ()
main = do
  putStrLn "== Original =="
  print (runWriter workflow)
  putStrLn "\n== With listen + pass (redacted) =="
  print (runWriter demo)
