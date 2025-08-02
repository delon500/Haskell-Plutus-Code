data PaymentMethod = Cash | Card | Cryptocurrency
    deriving (Show, Eq)

class Convertible a b where 
    convert :: a -> b 

instance Convertible PaymentMethod String where 
    convert Cash = "Cash"
    convert Card = "Card"
    convert Cryptocurrency = "Cryptocurrency"

main = do 
    putStrLn $ convert Cash
    putStrLn $ convert Card
    putStrLn $ convert Cryptocurrency