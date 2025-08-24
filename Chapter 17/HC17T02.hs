{-
- newtype wraps any Ord a value.
- The Semigroup operation (<>) picks the minimum for Min and the maximum for Max.
- Since min/max are associative, these instances satisfy the Semigroup law.
-}

import Data.Semigroup (Semigroup(..))

newtype Min a = Min {getMin :: a}
    deriving(Eq, Ord, Show)

instance Ord a => Semigroup (Min a) where 
    Min x <> Min y = Min (min x y)

newtype Max a = Max {getMax :: a} 
    deriving(Eq, Ord, Show)

instance Ord a => Semigroup (Max a) where 
    Max x <> Max y = Max (max x y)

main = do 
    print (Min 5 <> Min 2 <> Min 10)
    print (Max 5 <> Max 2 <> Max 10)