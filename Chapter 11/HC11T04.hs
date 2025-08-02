main = do 
    putStrLn "Enter first line"
    line1 <- getLine 
    putStrLn "Enter Second line"
    line2 <- getLine 

    putStrLn ("Concatenate string: " ++ line1 ++ " " ++ line2)