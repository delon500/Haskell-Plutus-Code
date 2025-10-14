safeProduct :: [Maybe Int] -> Maybe Int 
safeProduct [] = Just 1
safeProduct xs = fmap product (sequence xs)

main = do 
    print $ safeProduct [Just 2, Just 3, Just 4]
    print $ safeProduct [Just 5, Nothing, Just 2]
    print $ safeProduct []