class Concatenatable a where 
    concatWith :: a -> a -> a 

instance Concatenatable String where 
    concatWith = (++)

main = do 
    print $ concatWith "Hello, " "World!"
    print $ concatWith "Haskell " "Plutus"