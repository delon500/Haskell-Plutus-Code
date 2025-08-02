main = do 
    putStrLn "Enter first number: "
    input1 <- getLine 
    
    putStrLn "Enter second number: "
    input2 <- getLine 

    let number1 = read input1 :: Int 
        number2 = read input2 :: Int 
        result = number1 + number2 

    putStrLn ("The sum is " ++ show result)