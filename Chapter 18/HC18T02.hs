data Tree a 
    = Leaf a 
    | Node (Tree a) (Tree a) 
    deriving (Eq, Show)

instance Functor Tree where 
    fmap f (Leaf x) = Leaf (f x)
    fmap f (Node l r) = Node (fmap f l) (fmap f r)

binaryTree :: Tree Int 
binaryTree = Node (Leaf 1) (Node (Leaf 2) (Leaf 3))

{-
- fmap applies a function to each payload value.
- For Leaf, apply f directly to the contained a.
- For Node, recursively fmap into both subtrees, preserving the shape.
- Laws: this definition satisfies functor laws (fmap id = id, fmap (g∘h) = fmap g ∘ fmap h) 
    because we only reconstruct the same shape and apply the function exactly once to each stored value.
-}

main = do
    print binaryTree
    print (fmap (*10) binaryTree)
    print (fmap show binaryTree)
