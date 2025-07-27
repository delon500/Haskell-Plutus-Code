{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant map" #-}

anySquareGreaterThan50 :: [Int] -> Bool
anySquareGreaterThan50 xs = any (> 50) (map (^2) xs)

main = do
  print $ anySquareGreaterThan50 [2, 3, 4, 5]      
  print $ anySquareGreaterThan50 [2, 8, 3, 1]   

