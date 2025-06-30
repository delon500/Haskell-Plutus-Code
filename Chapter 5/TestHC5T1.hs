complexFunc :: Int -> Int
complexFunc x = x + 1

func :: Int -> Int
func x = complexFunc (complexFunc x)

funcTwo :: Int -> Int
funcTwo x = complexFunc (complexFunc x) + complexFunc (complexFunc x)

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

func1' :: Int -> Int
func1' x = applyTwice complexFunc x

funcTwo' :: Int -> Int
funcTwo' x = applyTwice complexFunc x + applyTwice complexFunc x

main = do
    print $ func1' 12
    print $ funcTwo' 12