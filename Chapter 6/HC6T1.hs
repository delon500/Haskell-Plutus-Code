factorialFunc :: Int -> Int
factorialFunc 0 = 1
factorialFunc 1 = 1
factorialFunc x = x * factorialFunc (x - 1) 

main = do
    print $ factorialFunc 0
    print $ factorialFunc 5
    print $ factorialFunc 1