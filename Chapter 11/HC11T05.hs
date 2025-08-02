repl = do 
    putStrLn "Enter something (or \"quit\" to stop)"
    input <- getLine 
    if input == "quit"
        then putStrLn "Good-bye!"
        else do
            putStrLn "You typed: "
            repl

main = repl 