import Control.Applicative (liftA2)

liftAndMultiply :: Applicative f => (Int ->  Int -> Int) 
    -> f Int -> f Int -> f Int
liftAndMultiply = liftA2 

main = do 
    print $ liftAndMultiply (*) (Just 3) (Just 4)
    print $ liftAndMultiply (*) (Just 3) Nothing  

    print $ liftAndMultiply (*) [2,3] [10,20]