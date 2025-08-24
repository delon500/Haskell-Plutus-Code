import Data.Semigroup (Product(..))

multiplyProducts :: Num a => [Product a] -> Product a 
multiplyProducts = mconcat

main = do 
    print $ multiplyProducts [Product 2, Product 3, Product 4]
    print $ multiplyProducts []