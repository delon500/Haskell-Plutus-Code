import System.Directory (listDirectory, doesFileExist)
import Control.Monad (filterM)
main = do 
    putStrLn "Files in the current directory"

    entries <- listDirectory "." 
    files <- filterM doesFileExist entries 

    mapM_ putStrLn files 