data Book = Book 
    { title :: String
    , author :: String
    , year :: Int 
    } deriving (Show, Eq) 

myBook :: Book
myBook = Book
    { title = "48 Laws of Power"
    , author = "Robert Greene"
    , year = 1998
    }

main = do 
    print myBook