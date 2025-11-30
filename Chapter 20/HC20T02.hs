sequenceMaybe :: [Maybe a] -> Maybe [a] 
sequenceMaybe [] = Just []
sequenceMaybe (mx:mxs) = do 
    x <- mx
    xs <- sequenceMaybe mxs
    Just (x:xs)

main = do 
    print (sequenceMaybe [Just 1, Just 2, Just 3])
    print $ sequenceMaybe [Just 'a', Nothing, Just 'c'] 