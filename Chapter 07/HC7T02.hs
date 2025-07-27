import Data.List (sort)

data Color
    = Red 
    | Green 
    | Blue
    deriving (Show, Eq)

instance Ord Color where
    compare Red Red = EQ
    compare Red _ = LT
    compare Green Red = GT
    compare Green Green = EQ
    compare Green Blue = LT
    compare Blue Blue = EQ
    compare Blue _ = GT

main = do
    print $ Red < Green
    print $ Green < Blue
    print $ Blue < Red
    print $ sort [Blue, Red, Green, Red]