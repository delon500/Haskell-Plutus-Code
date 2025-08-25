compositionLawCheck :: (Eq (f c), Functor f)
    => (b -> c)
    -> (a -> b)
    -> f a 
    -> Bool 

compositionLawCheck g h fa = 
    fmap (g . h) fa == (fmap g . fmap h) fa 

data Tree a = Leaf a | Node (Tree a) (Tree a)
    deriving(Eq, Show)

instance Functor Tree where 
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node l r) = Node (fmap f l) (fmap f r)

exampleTree :: Tree Int 
exampleTree = Node (Leaf 1) (Node (Leaf 2) (Leaf 3))

main = do 
    print $ compositionLawCheck (*2) (+1) ([1,2,3] :: [Int])
    print $ compositionLawCheck (++"!") reverse (Just "hi")
    print $ compositionLawCheck show (*10) exampleTree