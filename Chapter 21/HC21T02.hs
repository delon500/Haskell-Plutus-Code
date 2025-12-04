import Data.Monoid (Sum(..)) 

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

w1 :: Writer [String] Int
w1 = Writer (10, ["w1"])

f :: Int -> Writer [String] Int
f x = Writer (x + 1, ["f " ++ show x])

g :: Int -> Writer [String] Int
g x = Writer (x * 2, ["g " ++ show x])

checkFunctorIdentity :: Bool 
checkFunctorIdentity = runWriter (fmap id w1) == runWriter w1

checkFunctorComposition :: Bool
checkFunctorComposition =
    let u = (*3)
        v = (+2)
    in runWriter (fmap (u . v) w1) 
         == runWriter ((fmap u . fmap v) w1)

checkApplicativeIdentity :: Bool
checkApplicativeIdentity =
  let v = Writer ((+5), ["func"]) <*> Writer (7, ["arg"])
      lhs = (pure id <*> v)             :: Writer [String] Int
      rhs = v
  in runWriter lhs == runWriter rhs 

checkApplicativeHomomorphism :: Bool
checkApplicativeHomomorphism =
  -- pure f <*> pure x == pure (f x)
  let lhs = (pure (+3) <*> pure 4) :: Writer [String] Int
      rhs = (pure ((+3) 4))        :: Writer [String] Int
  in runWriter lhs == runWriter rhs

checkMonadLeftIdentity :: Bool
checkMonadLeftIdentity =
  -- return a >>= f == f a
  let a = 5
  in runWriter (pure a >>= f) == runWriter (f a)

checkMonadRightIdentity :: Bool
checkMonadRightIdentity =
  -- m >>= return == m
  runWriter (w1 >>= pure) == runWriter w1

checkMonadAssociativity :: Bool
checkMonadAssociativity =
  -- (m >>= f) >>= g == m >>= (\x -> f x >>= g)
  let lhs = (w1 >>= f) >>= g
      rhs = w1 >>= (\x -> f x >>= g)
  in runWriter lhs == runWriter rhs 

-- A tiny demo showing logs concat in-order
demo :: Writer [String] Int
demo = do
  tell ["start"]
  a <- f 3      
  b <- g a      
  tell ["done"]
  pure b 

main = do
  putStrLn "== Writer instances law checks =="
  putStrLn $ "Functor identity:        " ++ show checkFunctorIdentity
  putStrLn $ "Functor composition:     " ++ show checkFunctorComposition
  putStrLn $ "Applicative identity:    " ++ show checkApplicativeIdentity
  putStrLn $ "Applicative homomorphism:" ++ show checkApplicativeHomomorphism
  putStrLn $ "Monad left identity:     " ++ show checkMonadLeftIdentity
  putStrLn $ "Monad right identity:    " ++ show checkMonadRightIdentity
  putStrLn $ "Monad associativity:     " ++ show checkMonadAssociativity 
  
  putStrLn "\n== (logs in order) ==" 
  print (runWriter demo)
