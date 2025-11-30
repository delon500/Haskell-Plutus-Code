import Control.Monad (guard)

safeDivide :: (Eq a, Fractional a) => a -> a -> Maybe a
safeDivide x y = do 
    guard (y /= 0)
    return (x / y)    

main = do 
    print $ safeDivide 10 2 
    print $ safeDivide 10 3
    print $ safeDivide 5 0