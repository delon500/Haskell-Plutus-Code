class MinMax a where 
    minValue :: a 
    maxValue :: a 

instance MinMax Int where 
    minValue = minBound 
    maxValue = maxBound
    
main = do 
    print $ "minValue (Int) = " ++ show (minValue :: Int) 
    print $ "maxValue (Int) = " ++ show (maxValue :: Int)