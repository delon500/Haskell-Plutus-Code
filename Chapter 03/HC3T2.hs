grade:: Int -> String
grade x
    | x < 60 = "F"
    | (x >= 60) && (x <= 69 ) = "D"
    | (x>=70) && (x<=79) = "C"
    | (x>=80) && (x <= 89) = "B"
    | otherwise = "A"

main :: IO()
main = do
    putStrLn(grade 95)
    putStrLn(grade 72)
    putStrLn(grade 50)

    