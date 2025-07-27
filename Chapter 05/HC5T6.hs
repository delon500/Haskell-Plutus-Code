squareList :: [Int] -> [Int]
squareList = map (^2)

filterEven :: [Int] -> [Int]
filterEven = filter even

funcSquareEven :: [Int] -> [Int]
funcSquareEven = filterEven . squareList

main = do
    print $ funcSquareEven [1,2,3,4,5,6,7,8,9,10]


