squareArea :: Num a => a -> a
squareArea side = side * side

main = do
    print $ squareArea (5 :: Int)
    print $ squareArea (3.5 :: Double)
    print $ squareArea (2.5 :: Float)