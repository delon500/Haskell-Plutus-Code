fibonacci :: Int -> Int
fibonacci 0 = 0 
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

main = do 
    putStrLn "Enter Number: "
    num <- getLine
    let n = read num :: Int 
    print $ fibonacci n