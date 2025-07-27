data Shape a 
    = Circle 
        { color :: a
        , radius :: Float
        }
    | Rectangle 
        { color :: a 
        , width :: Float
        , height :: Float 
        }
    deriving (Show, Eq)

redCircle :: Shape String 
redCircle = Circle
    { color = "red"
    , radius = 5.0 
    }

blueRect :: Shape (Int,Int,Int)
blueRect = Rectangle
    { color = (0,0,255)
    , width = 10.0 
    , height = 5.0 
    }

main = do 
    print redCircle
    print blueRect