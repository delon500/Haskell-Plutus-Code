data Shape 
    = Circle 
        { center :: (Float, Float)
        , color :: String
        , radius :: Float
        }
    | Rectangle 
        { width :: Float
        , height :: Float
        , color :: String
        } 
    deriving (Show, Eq)

myCircle :: Shape 
myCircle = Circle
    { center = (0.0, 0.0)
    , color = "red"
    , radius = 5.0 
    }

myRectangle :: Shape
myRectangle = Rectangle
    { width = 10.0 
    , height = 5.0 
    , color = "blue"
    }

main = do 
    print myCircle
    print myRectangle 