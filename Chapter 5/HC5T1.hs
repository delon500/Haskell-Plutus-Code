applyTwice :: (Int -> Int) -> Int -> Int
applyTwice f x = f (f (f x))

addTwo :: Int -> Int
addTwo x = x + 2

funcApplyTwice :: Int -> Int
funcApplyTwice = applyTwice addTwo


main=do
    print $ funcApplyTwice 10

    