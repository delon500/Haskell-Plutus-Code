calculateCircleArea :: Floating a => a -> a
calculateCircleArea r = pi * (r * r)

main = do 
    let r1 = 5
    putStrLn("Area of circle with radius " ++ show r1 ++ ": "
        ++ show (calculateCircleArea r1))

    let r2 = 2.5 :: Float
    putStrLn("Area of circle with radius " ++ show r2 ++ ": "
        ++ show (calculateCircleArea r2)) 
