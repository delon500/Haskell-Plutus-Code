main :: IO()
main = do
    -- print $ 7 + 5
    -- print $ 10 * 4
    -- print $ 6 + 3 * 2
    -- print $ True && False
    
    -- print $ (+) 7 5
    -- print $ (*) 10 4
    -- print $ (*) ((+) 6 3) 2
    -- print $ (&&) True False

    putStrLn "Prefix notation"
    print $ (+) 5 3
    print $ (*) 10 4
    print $ (&&) True False

    putStrLn "Infix notation"
    print $ 7 + 2
    print $ 6 * 5
    print $ True && False



