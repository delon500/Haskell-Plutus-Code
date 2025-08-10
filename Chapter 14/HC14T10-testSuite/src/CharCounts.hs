module CharCounts (counts) where

import Data.List (group, sort)

counts :: String -> [(Char, Int)]
counts = map (\g -> (head g, length g)) . group . sort