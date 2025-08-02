import Data.Char (toUpper)

main = do 
    putStrLn "Enter Words: "
    words <- getLine 

    let upperWord = map toUpper words 

    putStrLn ("Uppercase Word: " ++ upperWord)


