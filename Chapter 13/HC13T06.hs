import qualified Data.Map.Strict as M 
import System.Directory (listDirectory, doesFileExist)
import Control.Monad (filterM)
import Data.List (isSuffixOf)

filesToMap :: [FilePath] -> M.Map FilePath Int 
filesToMap fps = M.fromList (zip fps [0..5]) 

isHsFile :: FilePath -> Bool 
isHsFile = isSuffixOf ".hs"

main = do 
    entries <- listDirectory "."

    fileOnly <- filterM doesFileExist entries

    let hsFiles = filter isHsFile fileOnly

    let fileMap = filesToMap hsFiles 

    putStrLn "Haskell source files mapped to their order index: "
    mapM_ print (M.toList fileMap)