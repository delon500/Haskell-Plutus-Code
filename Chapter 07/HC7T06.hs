circleCircmference :: (Real a, Floating b) => a -> b 
circleCircmference r = 2 * pi * realToFrac r 

main = do
    print $ circleCircmference (5 :: Int)
    print $ circleCircmference (3.5 :: Float)
    print (circleCircmference (7 :: Integer) :: Double)