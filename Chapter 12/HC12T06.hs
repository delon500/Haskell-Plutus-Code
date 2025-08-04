import Distribution.Compat.Prelude (readMaybe)
import Data.List (sort)

parseInts :: String -> Maybe [Int]
parseInts = mapM readMaybe . words 

main = do 
    putStrLn "Enter integers separated by spaces: "
    line <- getLine 
    case parseInts line of 
        Nothing -> putStrLn "Error: Please enter only valide integers"
        Just xs -> do 
            let sorted = sort xs 
            putStrLn "Sorted results:"
            print sorted