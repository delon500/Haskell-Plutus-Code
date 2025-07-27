maxOfThree :: Int -> Int -> Int -> Int
maxOfThree x y z =
    let 
        maxValue = max x y
    in max maxValue z

main = do
    print $ maxOfThree 10 20 15
    print $ maxOfThree 5 25 10

    