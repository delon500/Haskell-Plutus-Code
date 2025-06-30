digitsList :: Int -> [Int]
digitsList n 
    | n < 10 = [n]
    | otherwise = digitsList(n `div` 10) ++ [n `mod` 10]

main = do
    print $ digitsList 1234   
    print $ digitsList 5      
    print $ digitsList 907   