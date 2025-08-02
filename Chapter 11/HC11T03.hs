main = do 
    putStrLn "Enter a Number: "
    input <- getLine 
    let number = read input :: Int 
        numberDouble = number * 2 

    putStrLn("Double value: " ++ show numberDouble)