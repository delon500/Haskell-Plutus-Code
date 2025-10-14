newtype Wrapper a = Wrapper {getWrapper :: a}
    deriving (Eq, Show)

instance Functor Wrapper where
    fmap f (Wrapper x) = Wrapper (f x)

instance Applicative Wrapper where
    Wrapper f <*> Wrapper x = Wrapper (f x)
    pure = Wrapper

main = do 
    print $ fmap (+1) (Wrapper 41)
    print $ Wrapper (+3) <*> Wrapper 10 
    print $ (,) <$> Wrapper "hi" <*> Wrapper 5
