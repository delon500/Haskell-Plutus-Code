import Text.Read (readMaybe)

readIntOnce :: String -> IO (Maybe Int) 
readIntOnce prompt = do 
    putStrLn prompt 
    input <- getLine 
    pure (readMaybe input)

askDouble :: String -> IO Double 
askDouble prompt = do 
    putStrLn prompt 
    input <- getLine 
    case readMaybe input :: Maybe Double of 
        Just x -> pure x
        Nothing -> do 
            putStrLn "Invalid number. Try something like 3.14"
            askDouble prompt 

main = do 
    mN <- readIntOnce "Enter an integer: "
    case mN of
        Nothing -> putStrLn "Not a valid integer."
        Just n -> putStrLn $ "You entered: " ++ show n 

    d <- askDouble "Enter a floating-point number: "
    putStrLn $ "Thanks. Its square is " ++ show (d * d)