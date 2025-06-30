evenFilter :: [Int] -> [Int]
evenFilter [] = []
evenFilter (x:xs) 
    | even x = x : evenFilter xs
    | otherwise = evenFilter xs


main = do
    print $ evenFilter []
    print $ evenFilter [1,2,3,4,5,6,7,8]
    print $ evenFilter [1,3,5,7,20]


    