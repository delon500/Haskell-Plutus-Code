{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use product" #-}

productFunc :: [Int] -> Int
productFunc = foldl (*) 1

main = do
    print $ productFunc []
    print $ productFunc [2,3,4,5]
    print $ productFunc [1]
