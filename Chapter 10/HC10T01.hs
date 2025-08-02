class ShowSimple a where
    showSimple :: a -> String 

data PaymentMethod
    = Cash
    | Card 
    | Cryptocurrency 
    deriving (Eq, Show)

instance ShowSimple PaymentMethod where
    showSimple Cash = "Cash"
    showSimple Card = "Card"
    showSimple Cryptocurrency = "Cryptocurrency"

main = do 
    putStrLn $ showSimple Cash
    putStrLn $ showSimple Card 
    putStrLn $ showSimple Cryptocurrency