safeDiv :: (Eq a, Fractional a) => a -> a -> Maybe a
safeDiv _ y | y == 0 = Nothing
safeDiv x y = Just (x / y)

printDiv :: (Eq a, Fractional a, Show a) => a -> a -> IO ()
printDiv x y =  putStrLn $ 
    case safeDiv x y of 
        Nothing -> show x ++ " / " ++ show y ++ " = undefined (division by zero)"
        Just r  -> show x ++ " / " ++ show y ++ " = " ++ show r

safeDivInt :: Int -> Int -> Maybe Double
safeDivInt _ 0 = Nothing 
safeDivInt x y = Just (fromIntegral x / fromIntegral y)

main = do 
    printDiv 10.0 2.0       
    printDiv 5.0  0.0       
    print (safeDivInt 7 3)  
    print (safeDivInt 7 0)

