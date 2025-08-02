import Text.Read (readMaybe)

greetMe :: String -> String 
greetMe namet = "Hello: " ++ namet ++ "!" 

numberDouble :: Int -> Int 
numberDouble x = x * 2 


showMenu = do 
    putStrLn "\n === Menu ==="
    putStrLn "1) Greet me"
    putStrLn "2) Double a number"
    putStrLn "3) Count characters in a line"
    putStrLn "q) Quit" 
    putStrLn "Select an option: "

menuLoop = do 
    showMenu
    choice <- getLine 
    case choice of 
        "1" -> do 
            putStrLn "What is your name? "
            name <- getLine
            putStrLn (greetMe name)
            menuLoop
        "2" -> do 
            putStrLn "Enter a number: "
            num <- getLine
            case readMaybe num :: Maybe Int of 
                Just n -> putStrLn ("Result: " ++ show (numberDouble n))
                Nothing -> putStrLn "That wasn't a valid number."
            menuLoop
        "3" -> do 
            putStrLn "Enter a line"
            line <- getLine 
            putStrLn ("Character count: " ++ show (length line))
            menuLoop
        "q" -> putStrLn "Good-bye!"
        "Q" -> putStrLn "Good-bye!"
        _ -> do 
            putStrLn "Invalide option, try again."
            menuLoop

main = menuLoop 


