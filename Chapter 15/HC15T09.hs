import Control.Exception(try, IOException, evaluate)
import System.IO (hPutStrLn, stderr)

readFileSafely :: FilePath -> IO (Either IOException String)
readFileSafely path = try $ do 
    contents <- readFile path 
    _ <- evaluate (length contents) 
    pure contents

main = do 
    putStrLn "Enter a file path: "
    path <- getLine 

    e <- readFileSafely path 
    case e of 
        Left ioErr -> hPutStrLn stderr $ "Could not read file: " ++ show ioErr
        Right txt -> do 
            putStrLn "File contents: " 
            putStrLn txt