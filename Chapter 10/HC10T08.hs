class Eq a => AdvancedEq a where 
    compareEquality :: a -> a -> Bool
    compareEquality = (==)

instance AdvancedEq Bool 

main = do 
    print $ compareEquality True True 
    print $ compareEquality True False