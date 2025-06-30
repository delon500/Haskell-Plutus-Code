season :: Int -> String
season n 
    | n == 12 || n == 1 || n == 2 = "Winter"
    | n == 3 || n == 4 || n == 5 = "Spring"
    | n == 6 || n == 7 || n == 8 = "Summer"
    | n == 9 || n == 10 || n == 11 = "Autumn"
    | otherwise = "Not a season"

main = do
    print $ season 3
    print $ season 7 
    print $ season 11 