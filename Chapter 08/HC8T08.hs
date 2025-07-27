type Name = String 
type Age = Int 

greet :: Name -> Age -> String 
greet personName personAge = 
    "Hello, " ++ personName ++ "! You are " ++ 
    show personAge ++ " years old."

main = do 
    putStrLn $ greet "Lee" 30
    putStrLn $ greet "Jack" 47