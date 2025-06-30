describeTuble :: (Int, String) -> String
describeTuble (num, txt) =
    "You got "++ show num ++" marks" ++" in "++ txt

main = do
    print $ describeTuble (100, "Haskell programming")