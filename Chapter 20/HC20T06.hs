import Data.Maybe (maybeToList)

doubleMonad :: Maybe a -> [b] -> [(a, b)]
doubleMonad mx ys = do 
    x <- maybeToList mx
    y <- ys
    pure (x, y)

doubleMonad' :: Maybe a -> [b] -> [(a, b)]
doubleMonad' mx ys = (,) <$> maybeToList mx <*> ys

main :: IO ()
main = do
    print $ doubleMonad (Just 10) ["a", "b", "c"]
    print $ doubleMonad (Nothing :: Maybe Int) ["a", "b", "c"]
    print $ doubleMonad' (Just 'X') [1, 2, 3]  
    