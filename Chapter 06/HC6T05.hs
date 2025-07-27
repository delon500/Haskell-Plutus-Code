reverseFunc :: [a] -> [a]
reverseFunc [] = []
reverseFunc (x:xs) = reverseFunc xs ++ [x]

main = do 
    print $ reverseFunc [1,2,3,4]
