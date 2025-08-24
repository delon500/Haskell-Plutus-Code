{-
    - Semigroup uses (+) to combine wrapped values.
    - Monoid’s mempty is the additive identity 0.
    - The Num a constraint is required so we can use 0 and (+) for any numeric type (Int, Double, etc.).
-}
import Data.Semigroup (Semigroup(..))

newtype Sum a = Sum {getSum :: a}
    deriving (Eq, Show)

instance Num a => Semigroup (Sum a) where 
    Sum x <> Sum y = Sum (x + y)

instance Num a => Monoid (Sum a) where 
    mempty = Sum 0 
    mappend = (<>)

main = do 
    print (Sum 3 <> Sum 4)
    print (mempty <> Sum 10) 
    print (mconcat [Sum 1, Sum 2, Sum 3])
    print (getSum (mconcat [] :: Sum Int))