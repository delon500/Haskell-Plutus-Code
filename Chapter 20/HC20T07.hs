import Data.List (find)

maybeToEither :: e -> Maybe a -> Either e a
maybeToEither err = maybe (Left err) Right

findFirst :: (a -> Bool) -> [a] -> Either String a
findFirst p xs = maybeToEither "No matching element found" (find p xs)

findFirstWithIndex :: (a -> Bool) -> [a] -> Either String (Int, a)
findFirstWithIndex p xs =
    case [(i, x) | (i, x) <- zip [0..] xs, p x] of
        (hit:_) -> Right hit
        []      -> Left "No matching element found"

main = do 
    print $ findFirst even [1,3,5,6,7]
    print $ findFirst (>10) [1,3,5,6,7] 

    print $ findFirstWithIndex even [1,3,5,6,7]   
    print $ findFirstWithIndex (< 0) [1,3,5,6,7]