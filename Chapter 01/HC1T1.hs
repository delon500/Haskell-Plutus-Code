funcDouble :: Int -> Int
funcDouble x = x * 2

funcIncrement :: Int -> Int
funcIncrement x = x + 1

doubleThenIncrement :: Int -> Int
doubleThenIncrement = funcIncrement . funcDouble


main = do
    print $ doubleThenIncrement 5