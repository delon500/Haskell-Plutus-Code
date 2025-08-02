data Blockchain = Bitcoin | Ethereum | Cardano 
    deriving (Show, Ord)

 
instance Eq Blockchain where 
    a == b = not (a /= b)
    a /= b = case (a, b) of 
        (Bitcoin, Bitcoin) -> False 
        (Ethereum, Ethereum) -> False
        (Cardano, Cardano) -> False 
        _ -> True

main = do 
    print $ Bitcoin == Bitcoin
    print $ Bitcoin == Ethereum
    print $ Cardano /= Ethereum
    print $ Cardano /= Cardano

