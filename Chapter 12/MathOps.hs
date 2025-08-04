module MathOps 
( add
, sub 
, mul
, divSafe
) where

add :: Num a => a -> a -> a 
add x y = x + y 

sub :: Num a => a -> a -> a 
sub x y = x - y

mul :: Num a => a -> a -> a 
mul x y = x * y

divSafe :: (Eq a, Fractional a) => a -> a -> Maybe a 
divSafe _ 0 = Nothing 
divSafe x y = Just (x / y)