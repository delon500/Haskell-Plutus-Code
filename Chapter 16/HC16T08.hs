insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys) 
    | x <= y = x : y : ys
    | otherwise = y : insert x ys

insertionSort :: [Int] -> [Int]
insertionSort = foldr insert []

main = do 
    print $ insertionSort [5, 2, 8, 3, 1, 6]
    print $ insertionSort []
    print $ insertionSort [1, 11, 2, 1, 1 , 4]