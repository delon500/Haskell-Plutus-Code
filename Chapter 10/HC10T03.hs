import Data.List (sortBy)

class Comparable a where 
    compareWith :: a -> a -> Ordering

data Blockchain 
    = Bitcoin 
    | Ethereum 
    | Cardano 
    deriving (Show, Eq, Ord)

instance Comparable Blockchain where 
    compareWith = compare 

main = do 
    print $ compareWith Bitcoin Ethereum   
    print $ compareWith Cardano Bitcoin    
    print $ compareWith Ethereum Ethereum
    let chainList = [Cardano, Bitcoin, Ethereum]
    print $ sortBy compareWith chainList