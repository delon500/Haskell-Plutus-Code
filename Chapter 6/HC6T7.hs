listLength :: [a] -> Int
listLength [] = 0
listLength (_:xs) = 1 + listLength xs

main = do
    print $ listLength [1..10]
    print $ listLength []
    print $ listLength [20, 19, 18]