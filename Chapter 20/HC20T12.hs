import Control.Exception (try, IOException)

main = do 
    putStrLn "Enter file path:"
    path <- getLine
    result <- try (readFile path) :: IO (Either IOException String)
    case result of
        Left err  -> putStrLn $ "Failed to read file: " ++ show err
        Right txt -> mapM_ putStrLn (lines txt)