import Data.Semigroup (Semigroup((<>)), Sum(..))
import Data.List.NonEmpty (NonEmpty((:|)))
import qualified Data.List.NonEmpty as NE 

foldWithSemigroup :: Semigroup a => [a] -> Maybe a 
foldWithSemigroup = foldr step Nothing 
    where 
        step x Nothing = Just x 
        step x (Just acc) = Just (x <> acc) 

main = do 
    print (foldWithSemigroup [Sum 1, Sum 2, Sum 3])
    print (foldWithSemigroup ([] :: [Sum Int]))
    print (foldWithSemigroup ["has","ke","ll"])

