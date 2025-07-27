applyFunc :: (a -> b) -> [a] -> [b]
applyFunc _ [] = []
applyFunc f (x:xs) = f x : applyFunc f xs

main = do
    print $ applyFunc (^2) [1,2,2]
    print $ applyFunc (+2) [10, 11, 12]
    print $ applyFunc (subtract 1) [1, 2, 3]