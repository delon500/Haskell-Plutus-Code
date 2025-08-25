
boolToBit :: Bool -> Char 
boolToBit True = '1'
boolToBit False = '0'

mapToBits :: [Bool] -> [Char] 
mapToBits = fmap boolToBit

main = do 
    print $ mapToBits [True, False, True, True, False]
    print $ mapToBits []