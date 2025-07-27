greaterThan18 :: Int -> Bool
greaterThan18 x = x > 18

main = do
    print $ greaterThan18 4
    print $ greaterThan18 18
    print $ greaterThan18 19