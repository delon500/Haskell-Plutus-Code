factorial :: Int -> Int
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n-1)

main = do 
    print $ factorial 5
    print $ factorial 0
