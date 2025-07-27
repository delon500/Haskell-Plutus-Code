data Shape
    = Circle Double
    | Rectangle Double Double
    deriving (Eq, Ord, Show, Read)

class Describable a where 
    describe :: a -> String 

instance Describable Bool where
    describe True = "True value"
    describe False = "False value"

instance Describable Shape where
    describe (Circle r) = 
        "Circle of radius " ++ show r 
    describe (Rectangle w h) = 
        "Rectangle " ++ show w ++ " x " ++ show h 

describeAndCompare :: (Describable a, Ord a) => a -> a -> String
describeAndCompare x y 
    | x > y = "Larger is: " ++ describe x
    | x < y = "Larger is: " ++ describe y 
    | otherwise = "They're equal: " ++ describe x


main = do 
    putStrLn $ describeAndCompare True False 

    let s1 = Circle 2.5 
        s2 = Rectangle 3 3
    putStrLn $ describeAndCompare s1 s2 

    let s3 = Circle 2.5 
    putStrLn $ describeAndCompare s1 s3
