data PaymentMethod
    = Cash
    | Card
    | Cryptocurrency
    deriving (Show, Eq)

data Person = Person
    { name :: String
    , address :: (String, Int)
    , paymentMethod :: PaymentMethod
    } deriving (Show, Eq)

bill :: Person
bill = Person
    { name = "Bob"
    , address = ("043 Nelson st", 42)
    , paymentMethod = Cash
    }

main = do
    print bill
