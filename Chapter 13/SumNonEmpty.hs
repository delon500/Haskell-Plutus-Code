module SumNonEmpty(sumNonEmpty) where

sumNonEmpty :: Num a => [a] -> Either String a 
sumNonEmpty [] = Left errMsg
sumNonEmpty (x:xs) = Right (go x xs) 
    where
        go x [] = x
        go x (y:ys) = go (x+y) ys

errMsg :: String 
errMsg = "sumNonEmpty: empty list"