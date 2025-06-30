circleArea :: Float -> Float
circleArea x = 3.14 * (x * x)

maxOfThree :: Int -> Int -> Int -> Int
maxOfThree x y z = max x (max y z)

main :: IO()
main = do
    putStrLn "Enter Radius: "
    r <- getLine
    putStrLn "Enter first number: "
    num1 <- getLine
    putStrLn "Enter second number: "
    num2 <- getLine
    putStrLn "Enter third number: "
    num3 <- getLine

    let rds = read r :: Float
    let n1 = read num1 :: Int
    let n2 = read num2 :: Int
    let n3 = read num3 :: Int


    putStrLn ("Area of a circle: " ++ show (circleArea rds))
    putStrLn ("Maximum number: " ++ show (maxOfThree n1 n2 n3))

