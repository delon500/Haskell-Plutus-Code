pureAndApply :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
pureAndApply f x y = pure f <*> x <*> y 

main = do 
    putStrLn "-- Maybe --"
    print $ pureAndApply (+) (Just 2) (Just 5)
    print $ pureAndApply (+) (Just 4) Nothing

    putStrLn "-- List (Cartesian product) --"
    print $ pureAndApply (*) [2,3] [10,20]