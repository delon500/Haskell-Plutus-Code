data Shape 
    = Circle Float
    | Rectangle Float Float
    deriving (Show, Eq)

area :: Shape -> Float
area (Circle r) = pi * r * r 
area (Rectangle w h) = w * h 

circleArea :: Float
circleArea = area (Circle 5)

rectangleArea :: Float
rectangleArea = area (Rectangle 10 5)

main = do 
    putStrLn $ "Area of circle (r=5): " ++ show circleArea
    putStrLn $ "Area of rectangle (10 x 5): " ++ show rectangleArea