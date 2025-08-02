import Text.Read (readMaybe)

main = do
    putStrLn "Enter an Integer"
    input <- getLine
    case readMaybe input :: Maybe Int of
        Nothing -> putStrLn "That's not a valid integer."
        Just n -> do
            print n
            if even n
                then putStrLn "This is an Even number"
                else putStrLn "This is an Odd number"
