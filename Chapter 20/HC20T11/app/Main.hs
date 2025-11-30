{-# OPTIONS_GHC -Wall #-}
module Main where

import Control.Monad       (replicateM)
import Control.Monad.State.Strict
import System.Random       (StdGen, mkStdGen, randomR)

chooseStep :: State StdGen (Int, Int)
chooseStep = state $ \g ->
  let (k, g') = randomR (0, 3 :: Int) g
      step = case k of
        0 -> ( 1, 0)  -- east
        1 -> (-1, 0)  -- west
        2 -> ( 0, 1)  -- north
        _ -> ( 0,-1)  -- south
  in (step, g')

randomWalk :: Int -> State StdGen [(Int, Int)]
randomWalk n = do
  steps <- replicateM n chooseStep              
  let add (x,y) (dx,dy) = (x+dx, y+dy)
      path = scanl add (0,0) steps             
  pure path

-- Demo
main :: IO ()
main = do
  let n        = 10
      seed     = 42
      (path,_) = runState (randomWalk n) (mkStdGen seed)
  putStrLn $ "Random walk (" ++ show n ++ " steps) starting at (0,0):"
  mapM_ print path
