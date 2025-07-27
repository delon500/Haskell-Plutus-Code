data Shape 
    = Circle Double
    | Rectangle Double Double
    deriving (Show, Read)

class Describable a where
    describe :: a -> String

instance Describable Bool where
    describe True = "A truthy value: True"
    describe False = "A falsy value: False"

instance Describable Shape where
    describe (Circle r) = 
        "Circle with radius " ++ show r
    describe (Rectangle w h) = 
        "Rectangle of width " ++ show w ++ " and height " ++ show h


main = do
    putStrLn $ describe True
    putStrLn $ describe False

    let s1 = Circle 2.5 
        s2 = Rectangle 3 4 

    putStrLn $ describe s1
    putStrLn $ describe s2
    