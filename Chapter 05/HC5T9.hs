transformList :: (a -> a) -> [a] -> [a]
transformList f = map (f . f)

addFunc x = x * 2

main :: IO ()
main = do
    print $ transformList addFunc [1, 2, 3, 4]