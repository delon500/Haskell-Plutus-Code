import Data.Semigroup ((<>))

combineLists :: [Int] -> [Int] -> [Int]
combineLists xs ys = xs <> ys

main = do 
    print (combineLists [1,2,3] [4,5])
    print (combineLists [] [10,20])
    print [combineLists [7,8] []]