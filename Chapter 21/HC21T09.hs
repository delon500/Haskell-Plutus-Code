newtype State s a = MkState { runState :: s -> (a, s) }

instance Functor (State s) where
    fmap f (MkState g) = MkState $ \s -> 
        let 
            (a, newState) = g s
        in 
            (f a, newState)

instance Applicative (State s) where
    pure a = MkState $ \s -> (a, s)
    (MkState f) <*> (MkState g) = MkState $ \s -> 
        let (func, state1) = f s
            (a, state2) = g state1
        in (func a, state2)

instance Monad (State s) where
    MkState sa >>= k = MkState $ \s -> 
        let (a, s1) = sa s
            MkState b = k a
        in b s1

get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = MkState $ \s -> ((), f s)

mapCount :: (a -> b) -> [a] -> State Int [b]
mapCount f = traverse (\x -> modify (+1) >> pure (f x))

main = do 
    let (mapped, count) = runState (mapCount (*2) [1,2,3,4,5]) 0
    putStrLn $ "Mapped : " ++ show mapped
    putStrLn $ "Count  : " ++ show count