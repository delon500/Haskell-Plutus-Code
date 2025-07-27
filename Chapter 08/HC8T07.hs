data Animal 
    = Dog String
    | Cat String
    deriving (Show, Eq)

describeAnimal :: Animal -> String 
describeAnimal (Dog name) = "This dog's name is " ++ name
describeAnimal (Cat name) = "This cat's name is " ++ name

scooby :: Animal
scooby = Dog "Scooby"

garfield :: Animal
garfield = Cat "Garfield"

main = do 
    putStrLn $ describeAnimal scooby
    putStrLn $ describeAnimal garfield 