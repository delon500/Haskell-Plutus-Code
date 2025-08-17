import Data.Char (toUpper)
convertUpper :: String -> String
convertUpper = map toUpper

main = do 
    print $ convertUpper "hello" 
     