applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

main = do
    print $ applyTwice (+3) 10
    