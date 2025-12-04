newtype Writer w a = Writer { runWriter :: (a, w) }
  
instance Functor (Writer w) where
    fmap f (Writer (a, w)) = Writer (f a, w)

instance Monoid w => Applicative (Writer w) where
    pure a = Writer (a, mempty)
    Writer (f, w1) <*> Writer (a, w2) = Writer (f a, w1 <> w2)

instance Monoid w => Monad (Writer w) where
    Writer (a, w1) >>= k =
        let Writer (b, w2) = k a
        in Writer (b, w1 <> w2)

tell :: Monoid w => w -> Writer w ()
tell w = Writer ((), w)

addW :: Int -> Int -> Writer [String] Int
addW x y = 
    let result = x + y
    in Writer (result, ["Added " ++ show x ++ " and " ++ show y ++ " to get " ++ show result ++ ".\n"])

subW :: Int -> Int -> Writer [String] Int
subW x y = 
    let result = x - y
    in Writer (result, ["Subtracted " ++ show y ++ " from " ++ show x ++ " to get " ++ show result ++ ".\n"])

multW :: Int -> Int -> Writer [String] Int
multW x y = 
    let result = x * y
    in Writer (result, ["Multiplied " ++ show x ++ " and " ++ show y ++ " to get " ++ show result ++ ".\n"])

calcDemo :: Writer [String] Int
calcDemo = do
    a <- addW 3 5
    b <- multW 2 a
    subW b 4

main = do 
    let (result, logs) = runWriter calcDemo
    putStrLn $ "Result: " ++ show result
    putStrLn "Log:"
    mapM_ putStrLn logs 