isLeapYear :: Int -> Bool
isLeapYear x = 
    if x `mod` 400 == 0 then True
    else if x `mod` 100 == 0 then False
    else if x `mod` 4 == 0 then True
    else False
    
main :: IO()
main = do
    print $ isLeapYear 2000
    print $ isLeapYear 1900
    print $ isLeapYear 2024