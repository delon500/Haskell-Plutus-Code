exists :: Eq a => a -> [a] -> Bool 
exists _ [] = False 
exists x (y:ys) = x == y || exists x ys

main = do 
    print (exists 3 [1,2,3,4])        
    print (exists 5 [1,2,3,4])      
    print (exists 'a' "haskell")
    print (exists 'l' "haskell")