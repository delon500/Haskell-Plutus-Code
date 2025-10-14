data Pair a = Pair a a 
    deriving (Eq, Show)

instance Functor Pair where 
    fmap f (Pair x y) = Pair (f x) (f y)

instance Applicative Pair where 
    pure x = Pair x x 
    Pair f g <*> Pair x y = Pair (f x) (g y) 


{-

-}
main = do 
    print $ fmap (+1) (Pair 1 2)
    print $ Pair (+1) (*10) <*> Pair 3 4