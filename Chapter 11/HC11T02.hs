main = do 
    putStrLn "Enter words"
    word <- getLine 
    let wordLength = length word
    putStrLn ("Character count: " ++ show wordLength)