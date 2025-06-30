{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use sum" #-}

-- 1 + (2 + (3 + (4 + 0)))
-- 1 + (2 + (3 + 4))
-- 1 + (2 + 7)
-- 1 + 9
-- 10
-- Works from end → start

sumFunc :: [Int] -> Int
sumFunc = foldr (+) 0 

main = do
    print $ sumFunc [1]
    print $ sumFunc [1, 2, 3, 4]
    print $ sumFunc []