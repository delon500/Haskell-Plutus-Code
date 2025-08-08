import System.Directory (listDirectory)
import Data.List (filter, sort, isInfixOf)

getSortedFilteredFiles :: String -> IO [FilePath]
getSortedFilteredFiles keyword = do 
    files <- listDirectory "."
    let filtered = filter (isInfixOf keyword) files
    return (sort filtered)

main = do 
    putStrLn "Enter substring to filter files:"
    keyword <- getLine
    sortedFiles <- getSortedFilteredFiles keyword
    putStrLn "\nSorted and matching files:"
    mapM_ putStrLn sortedFiles