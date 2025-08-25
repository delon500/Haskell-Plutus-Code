data Tree a = Leaf a | Node (Tree a) (Tree a) 
    deriving (Eq, Show)

instance Functor Tree where 
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node l r) = Node (fmap f l) (fmap f r)

incrementTreeValues :: Num a => Tree a -> Tree a 
incrementTreeValues = fmap (+1)

binaryTree :: Tree Int 
binaryTree = Node (Leaf 1) (Node (Leaf 2) (Leaf 3))

main = do
    print binaryTree
    print (incrementTreeValues binaryTree)
