import Data.Char (isUpper)

checkUpperCase :: [String] -> Bool
checkUpperCase = any anyUpper
    where
        anyUpper :: String -> Bool
        anyUpper (x:_) = isUpper x
        anyUpper [] = False

main = do
    print $ checkUpperCase ["i","L","V","U"]
    print $ checkUpperCase ["word","yes","today"]
    print $ checkUpperCase ["Q", "w", "e", "r", "t"]


