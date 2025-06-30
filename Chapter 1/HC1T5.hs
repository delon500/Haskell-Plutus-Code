infiniteNumber :: Int -> [Int]
infiniteNumber x = take x [1..]

main = do
    print $ infiniteNumber 5