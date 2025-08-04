import System.Environment (getArgs)
import System.IO (hPutStrLn, stderr)
import System.IO.Error (isDoesNotExistError)
import Control.Exception (catch, IOException)

printFileSafely :: FilePath-> IO() 
printFileSafely path = do 
    contents <- readFile path 
    putStrLn contents 
    `catch` handler 
    where 
        handler :: IOException -> IO ()
        handler e 
            | isDoesNotExistError e = 
                hPutStrLn stderr ("Error: file \"" ++ path ++ "\" does not exist.")
            | otherwise = 
                hPutStrLn stderr ("I/O error while reading \"" ++ path ++ "\": " ++ show e)

main = do 
    putStrLn "Enter a file path"
    filePath <- getLine 
    printFileSafely filePath