import Data.List (sort)

mergeLists :: Ord a => [a] -> [a] -> [a]
mergeLists xs [] = xs
mergeLists [] ys = ys
mergeLists (x:xs) (y:ys)
    | x <= y = x : sort (mergeLists xs (y:ys))
    | otherwise = y : sort (mergeLists (x:xs) ys)

main = do
    let list1 = [71, 12, 3]
        list2 = [4, 50, 6]
        mergeList = mergeLists list1 list2

    putStrLn $ "Merging " ++ show list1 ++ " and " ++ show list2 ++ ":"
    print mergeList