data Color 
    = Red 
    | Green
    | Blue 
    deriving (Eq, Show, Enum, Bounded)

nextColor :: Color -> Color
nextColor c 
    | c == maxBound = minBound
    | otherwise = succ c 

main = do 
    print $ map nextColor [Red, Green, Blue]
    let cycle3 = take 5 (iterate nextColor Red)
    print cycle3