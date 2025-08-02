main = do 
    putStrLn "Enter input: "
    input <- getLine

    let word = reverse input 

    putStrLn ("The reverse text: " ++ word) 