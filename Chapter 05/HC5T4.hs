{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}
main = do
    print $ (\x -> x > 10) 3 
    print $ (\x -> x > 10) 10
    print $ (\x -> x > 10) 13 
    