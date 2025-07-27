firstAndThird :: [Int] -> [Int]
firstAndThird (x:rest) = [x, ((x:rest) !! 2 )]
-- firstAndThird (x:_:z:_) = [x,z]
firstAndThird _ ="No values"

main = do
    print $ firstAndThird [2,4,6,8,10,12,14]
