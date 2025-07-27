data Person = Person
    { name :: String
    , age :: Int
    , isEmployed :: Bool
    } deriving (Show, Eq)

person1 :: Person
person1 = Person
    { name = "Ace"
    , age = 30
    , isEmployed = True
    }

person2 :: Person
person2 = Person
    { name = "bill"
    , age = 25
    , isEmployed = False
    }

main = do 
    putStrLn $ "Person 1: " ++ show person1
    putStrLn $ "Person 2: " ++ show person2
