compareValues :: (Eq a, Ord a) => a -> a -> a 
compareValues x y 
    | x == y = x 
    | x < y = y
    | otherwise = x 

main = do
    print $ compareValues 3 5
    print $ compareValues 10 2
    print $ compareValues 'a' 'b'
    print $ compareValues "h" "h"