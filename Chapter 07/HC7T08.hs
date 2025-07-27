import Distribution.Compat.Prelude (readMaybe)
data Shape
    = Circle Double
    | Rectangle Double Double
    deriving (Show, Read)

parseShape :: String -> Maybe Shape
parseShape  = readMaybe 

main = do 
    print $ parseShape "Circle 2.5"
    print $ parseShape "Rectangle 3.0 4.0"
    print $ parseShape "Square 5"
    print $ parseShape "Circle abc"
