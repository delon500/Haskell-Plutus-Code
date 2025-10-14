module Main where

import Control.Applicative (liftA2, liftA3)

combineEitherResults2 :: Either e a -> Either e b -> Either e (a, b)
combineEitherResults2 = liftA2 (,)

combineEitherResults3 :: Either e a -> Either e b -> Either e c -> Either e (a, b, c)
combineEitherResults3 = liftA3 (,,)

combineEitherResults :: [Either e a] -> Either e [a]
combineEitherResults = sequenceA

main :: IO ()
main = do
  print $ (combineEitherResults [Right "ok", Right "fine"] :: Either String [String])       
  print $ (combineEitherResults [Right "ok", Left "bad", Right "x"] :: Either String [String])
  print $ (combineEitherResults2 (Right "ok") (Right "fine") :: Either String (String, String))
