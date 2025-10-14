import Control.Applicative (liftA2, liftA3)

simulateMaybeEffect2 :: (a -> b -> c) -> Maybe a -> Maybe b -> Maybe c
simulateMaybeEffect2 = liftA2

simulateMaybeEffect3 :: (a -> b -> c -> d) 
    -> Maybe a -> Maybe b -> Maybe c -> Maybe d
simulateMaybeEffect3 = liftA3

sum3 :: Int -> Int -> Int -> Int
sum3 x y z = x + y + z

concat3 :: String -> String -> String -> String
concat3 a b c = a ++ b ++ c

main = do 
    print $ simulateMaybeEffect2 (*) (Just 3) (Just 5)
    print $ simulateMaybeEffect2 (++) (Just "Hello, ") (Just "World!")

    print $ simulateMaybeEffect3 sum3 (Just 1) (Just 2) (Just 3)
    print $ simulateMaybeEffect3 sum3 (Just 1) Nothing (Just 3)

    print $ simulateMaybeEffect3 concat3 (Just "Ha") (Just "ske") (Just "ll")