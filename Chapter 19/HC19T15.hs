module Main where

import Control.Applicative (liftA2)

sequenceEffects :: Applicative f => [f a] -> f [a]
sequenceEffects = foldr (liftA2 (:)) (pure [])

main :: IO ()
main = do
  print $ sequenceEffects [Just 1, Just 2, Just 3]    
  print $ sequenceEffects [Just 1, Nothing, Just 3 :: Maybe Int] 

  print $ (sequenceEffects [Right 'a', Right 'b']        :: Either String [Char]) 
  print $ (sequenceEffects [Right 'a', Left "err", Right 'b'] :: Either String [Char]) 

  putStrLn "Enter two words:"
  xs <- sequenceEffects [getLine, getLine]
  print xs
