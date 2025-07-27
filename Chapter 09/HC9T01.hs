type Address = String 

type Entity a = (a, Address)

personEntity :: Entity String
personEntity = ("Daniel","75 Avenue St")

orderEntity :: Entity Int
orderEntity = (42, "Warehouse 7, Dock 3")

main = do 
    putStrLn $ "Person entity: " ++ show personEntity
    putStrLn $ "Order entity: " ++ show orderEntity