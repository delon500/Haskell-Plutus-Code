triangleType :: Float -> Float -> Float -> String
triangleType x y z
    | x == y && y == z = "Equilateral"
    | x == y || y == z || z == x = "Isosceles"
    | otherwise = "Scalene"

main :: IO()
main = do
    print $ triangleType 3 3 3
    print $ triangleType 5 5 8
    print $ triangleType 6 7 8



