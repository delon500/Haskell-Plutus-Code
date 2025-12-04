import Data.Monoid (Sum(..), Product(..))

-- Custom Writer (result, log)
newtype Writer w a = Writer { runWriter :: (a, w) }

instance Functor (Writer w) where
  fmap f (Writer (a, w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  Writer (f, w1) <*> Writer (a, w2) = Writer (f a, w1 <> w2)

instance Monoid w => Monad (Writer w) where
  Writer (a, w1) >>= k =
    let Writer (b, w2) = k a
    in Writer (b, w1 <> w2)

tell :: Monoid w => w -> Writer w ()
tell w = Writer ((), w)

-- ========= Variant A: Count steps with Sum Int =========

type LogCount = Sum Int

step :: Writer LogCount ()
step = tell (Sum 1)      -- one step occurred

-- Wrap arithmetic ops and count how many operations we did
addW :: Int -> Int -> Writer LogCount Int
addW x y = do
  step
  pure (x + y)

mulW :: Int -> Int -> Writer LogCount Int
mulW x y = do
  step
  pure (x * y)

calcCount :: Writer LogCount Int
calcCount = do
  a <- addW 2 3   -- +1
  b <- mulW a 4   -- +1
  mulW b 2        -- +1  => total steps = 3

-- ========= Variant B: Multiply weights with Product Int =========

type LogWeight = Product Int

bump :: Int -> Writer LogWeight ()
bump n = tell (Product n)  -- multiply the accumulated weight by n

-- Same shape, different monoid = different effect
calcWeight :: Writer LogWeight Int
calcWeight = do
  a <- pure 7
  bump 2     -- ×2
  b <- pure (a * 3)
  bump 5     -- ×5  => final weight = 2 * 5 = 10
  pure b     -- value = 21, weight = Product 10

main :: IO ()
main = do
  putStrLn "== Sum Int (count steps) =="
  let (resultC, steps) = runWriter calcCount
  putStrLn $ "Result: " ++ show resultC
  putStrLn $ "Steps : " ++ show (getSum steps)

  putStrLn "\n== Product Int (multiply weights) =="
  let (resultW, weight) = runWriter calcWeight
  putStrLn $ "Result: " ++ show resultW
  putStrLn $ "Weight: " ++ show (getProduct weight) 

{-
Writer’s behavior is entirely determined by the monoid w.
- With w [String], logs are lists that append (<> = list concatenation). 
The effect is message accumulation.

- With w Sum Int, mempty = 0 and (<>) = (+). 
The effect becomes counting occurrences (e.g., number of steps/ops).

With w Product Int, mempty = 1 and (<>) = (*). 
The effect becomes multiplicative weighting (e.g., scaling factors, probabilities, costs).

Same code shape (same tell, same do-blocks); 
only the monoid instance swaps the semantics from “collect messages” → “count” → “multiply”.
-}
