data Box a 
    = Empty 
    | Has a 
    deriving (Show, Eq)

extract :: a 
    -> Box a 
    -> a 
extract def Empty = def
extract _ (Has x) = x 

main = do 
    print $ extract 0 Empty
    print $ extract 0 (Has 42)
    print $ extract "nope" Empty
    print $ extract "nope" (Has "yes!")