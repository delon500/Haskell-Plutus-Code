checkNumber :: Int -> String
checkNumber x = 
    if x > 0 
        then "Positive"
        else if x < 0
            then "Negative"
            else "Zero"


main :: IO()
main = do
    putStrLn (checkNumber 5)
    putStrLn (checkNumber (-3))
    putStrLn (checkNumber (-0))
