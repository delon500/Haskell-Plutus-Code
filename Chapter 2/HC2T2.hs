add :: Int -> Int -> Int
add x y = x + y
--

isEven :: Int -> Bool
isEven x = x `mod` 2  == 0

concatString :: String -> String -> String
concatString x y = x ++ y

main :: IO()
main = do
    print $ add 1 2
    print $ isEven 5
    print $ concatString "Delon " "Wenyeve"