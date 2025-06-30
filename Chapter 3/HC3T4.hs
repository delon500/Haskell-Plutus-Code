triangleArea :: Float -> Float -> Float -> Float
triangleArea a b c =
    let 
        s = (a + b + c) / 2
    in 
        sqrt(s * (s - a) * (s - b) * (s - c))

main :: IO()
main = do
    print (triangleArea 3 4 5)
    print (triangleArea 7 8 9)

    