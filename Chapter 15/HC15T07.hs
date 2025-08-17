import Text.Read (readMaybe)

safeDiv :: (Eq a, Fractional a) => a -> a -> Maybe a 
safeDiv _ 0 = Nothing 
safeDiv x y = Just (x / y)

parseDouble :: String -> Maybe Double 
parseDouble = readMaybe 

parsePositive :: String -> Maybe Double
parsePositive s = do 
    x <- readMaybe s 
    if x > 0 then Just x else Nothing

velocityMaybe :: String -> String -> Maybe Double 
velocityMaybe distText timeText = do 
    d <- parseDouble distText
    t <- parsePositive timeText 
    safeDiv d t

velocityExplained :: String -> String -> Either String Double 
velocityExplained distText timeText = 
    case (parseDouble distText, parseDouble timeText) of 
        (Nothing, _) -> Left "Invalid distance: Please enter a number."
        (_, Nothing) -> Left "Invalid time: Please enter a positive number."
        (Just _, Just t) | t <= 0 -> Left "Time must be greater than zero."
        (Just d, Just t) -> 
            case safeDiv d t of 
                Nothing -> Left "Cannot divide by zero."
                Just v -> Right v

main = do 
    putStrLn "Enter distance: "
    distText <- getLine
    putStrLn "Enter time: (>0):"
    timeText <- getLine

    case velocityExplained (distText) (timeText) of 
        Left err -> putStrLn $ "Error: " ++ err 
        Right v -> putStrLn $ "Velocity: " ++ show v