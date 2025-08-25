import Data.Char (toLower)

mapToLower :: String -> String
mapToLower = fmap toLower

mapToLowerF :: Functor f => f Char -> f Char 
mapToLowerF = fmap toLower

main = do 
    print $ mapToLower "HaSkElL"
    print $ mapToLowerF "A"
    print $ mapToLowerF ['p','L', 'U','t','U','S']