data Box a 
    = Empty
    | Has a 
    deriving (Show, Eq)

addN :: Num a => a -> Box a -> Box a 
addN _ Empty    = Empty
addN n (Has x) = Has (x + n) 

main = do 
    print $ addN 5 (Has 10)
    print $ addN 5 Empty
    print $ addN 3 (Has 7.2) 
