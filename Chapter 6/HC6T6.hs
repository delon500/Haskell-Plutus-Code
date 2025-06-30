findElement :: Eq a => a -> [a] -> Bool
findElement _ [] = False
findElement target (x:xs)
    | target == x = True
    | otherwise = findElement target xs

main = do
    print $ findElement 1 [0, 2, 5, 7]
    print $ findElement 3 []
    print $ findElement 2 [4, 5, 6, 2]