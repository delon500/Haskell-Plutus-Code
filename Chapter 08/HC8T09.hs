type Address = String 
type Value = Int

data Transaction = Transaction 
    { from :: Address
    , to :: Address
    , amount :: Value
    , transactionId :: String
    } deriving (Show, Eq)


createTransaction :: Address -> Address -> Value -> String
createTransaction fromAddr toAddr val = 
    let txId = fromAddr ++ "->" ++ toAddr ++ ":" ++ show val
        tx = Transaction
                { from = fromAddr
                , to = toAddr
                , amount = val
                , transactionId = txId 
                }
    in txId

main = do 
    let sender = "John"
        recipient = "Bill"
        amt = 250 
        tid = createTransaction sender recipient amt 
    putStrLn $ "Created transaction ID: " ++ tid