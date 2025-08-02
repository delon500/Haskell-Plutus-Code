{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

data Box a = Box a
    deriving Show 

instance Eq a => Eq (Box a) where 
    (Box x) == (Box y) = x == y

main = do
    let b1 = Box 5
        b2 = Box 5 
        b3 = Box 10
    print $ b1 == b2 
    print $ b1 == b3 
    print $ b1 /= b3 
    