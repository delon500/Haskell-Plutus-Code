nestedFmap :: (Functor f, Functor g) => (a -> b) -> f (g a) -> f (g b)
nestedFmap = fmap . fmap

main = do 
    print $ nestedFmap (+1) (Just [1,2,3])
    print $ nestedFmap (+1) [Just 1, Nothing, Just 3]
    print $ nestedFmap length (Just ["ab","c"])