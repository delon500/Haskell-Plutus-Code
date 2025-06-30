smallNumber :: Int
smallNumber = 2 ^ 62

bigNumber :: Integer
bigNumber = 2^127

main :: IO()
main = do
    putStrLn ("smallNumber: "++ show smallNumber)
    putStrLn ("bigNumber: " ++ show bigNumber)