import System.Directory (listDirectory, doesFileExist)
import Data.List        (filter, isInfixOf, sort)
import Control.Monad    (filterM)
import Data.Char        (toLower)

infixSearch :: String -> String -> Bool
infixSearch needle hay =
  let lower = map toLower
  in  lower needle `isInfixOf` lower hay

findFiles :: String -> IO [FilePath]
findFiles needle = do
  entries <- listDirectory "."           
  files   <- filterM doesFileExist entries
  pure (sort (filter (infixSearch needle) files))

main :: IO ()
main = do
  putStrLn "Enter substring to search for in the current directory:"
  sub <- getLine
  matches <- findFiles sub
  putStrLn "\nSorted matching files:"
  mapM_ putStrLn matches
