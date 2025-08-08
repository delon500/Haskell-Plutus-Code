import System.Directory (listDirectory)
import Data.List (isInfixOf)
import Control.Monad (filterM)

filterFilesBySubString :: String -> IO [FilePath]
filterFilesBySubString keyword = do
    files <- listDirectory "."
    return (filter (isInfixOf keyword) files)

main = do 
    putStrLn "Enter substring to filter files:"
    keyword <- getLine 
    matchingFiles <- filterFilesBySubString keyword
    putStrLn "\nMatching files:"
    mapM_ putStrLn matchingFiles
