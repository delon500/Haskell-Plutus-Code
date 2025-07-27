addFunc :: Int -> Int -> Int
addFunc x y = x + y

multiplyFunc :: Int -> Int -> Int
multiplyFunc c v = c * v

addFuncTwo = addFunc 1

multiFuncTwo = multiplyFunc 2

main = do
    print $ addFuncTwo 10
    print $ multiFuncTwo 5


    