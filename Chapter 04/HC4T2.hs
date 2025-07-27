dayType :: String -> String
dayType "Saturday" = "It's a weekend!" 
dayType "Sunday" = "It's a weekend!"
dayType "Monday" = "Its a weekday."
dayType "Tuesday" = "It's a weekday."
dayType "Wednesday" = "It's a weekday."
dayType "Thursday" = "It's a weekday."
dayType "Friday" = "It's a weekday."
dayType _ = "Invalid day"

main :: IO()
main = do
    print $ dayType "Monday"
    print $ dayType "Saturday"
    print $ dayType "day"

