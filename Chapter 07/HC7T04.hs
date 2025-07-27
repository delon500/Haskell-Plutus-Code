data Shape 
    = Circle Double
    | Rectangle Double Double
    deriving (Show, Read)

main = do
    let c1 = Circle 2.5 
        r1 = Rectangle 3 4

    print c1 
    print r1

    let c2 = read "Circle 2.5" :: Shape 
        r2 = read "Rectangle 3.0 4.0" :: Shape 

    print c2 
    print r2  

    