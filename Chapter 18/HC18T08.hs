identityLawCheck :: (Eq (f a), Functor f) => f a -> Bool 
identityLawCheck fa = fmap id fa == fa 

data Tree a = Leaf a | Node (Tree a) (Tree a) 
    deriving (Eq, Show)

instance Functor Tree where 
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node l r) = Node (fmap f l) (fmap f r)

exampleTree :: Tree Int 
exampleTree = Node (Leaf 1) (Node (Leaf 2) (Leaf 3))

main = do 
    print $ identityLawCheck [1,2,3 :: Int]
    print $ identityLawCheck (Just "hi")
    print $ identityLawCheck (Nothing :: Maybe Int)
    print $ identityLawCheck exampleTree