whatsInsideThisList :: [Int] -> String
whatsInsideThisList [] = "Empty List"
whatsInsideThisList [x] = "A single element in the list: "++ show x
whatsInsideThisList [x, y] = "Elements are "++ show x ++ " and " ++ show y 
whatsInsideThisList (x:rest) = "The last element is: " ++ show (last (x:rest))

main = do
    print $ whatsInsideThisList []
    print $ whatsInsideThisList [5, 6]
    print $ whatsInsideThisList [8,9]
    print $ whatsInsideThisList [0,5,8,9,5,7,10]
    print $ whatsInsideThisList [10]
