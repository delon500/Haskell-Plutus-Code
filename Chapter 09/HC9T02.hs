data Box a 
    = Empty
    | Has a
    deriving (Show, Eq)

emptyBox :: Box Int 
emptyBox = Empty 

intBox :: Box Int
intBox = Has 42

stringBox :: Box String
stringBox = Has "Hi, Box!"

main = do 
    print emptyBox
    print intBox
    print stringBox