class Summable a where
    sumUp :: [a] -> a

instance Summable Int where
    sumUp = sum

main = do
    print $ sumUp ([1,2,3] :: [Int])
    print $ sumUp ([] :: [Int])