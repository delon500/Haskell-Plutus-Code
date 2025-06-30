isPalidrome :: String -> Bool
isPalidrome text 
    | length text <= 1 = True
    | head text == last text = isPalidrome (init (tail text))
    | otherwise = False 

main = do 
    print $ isPalidrome "racecar"
    print $ isPalidrome "haskell"
    print $ isPalidrome "madam"


    