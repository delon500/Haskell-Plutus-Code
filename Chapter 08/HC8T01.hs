type Address = String
type Value = Int

generateTx :: Address -> Address -> Value -> String
generateTx from to amount = 
    from ++ " -> " ++ to ++ ": " ++ show amount

main = do 
    putStrLn $ generateTx "Ace" "Bill" 250
    putStrLn $ generateTx "Carol" "David" 1024