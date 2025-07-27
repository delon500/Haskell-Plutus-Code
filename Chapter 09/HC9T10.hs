data BST a 
    = Empty
    | Node 
        {value :: a
        , left :: BST a
        , right :: BST a
        }
    deriving (Show, Eq)

bstTree :: BST Int
bstTree = 
    Node 5
        (Node 3 Empty Empty)
        (Node 7 Empty Empty)

main = do 
    print bstTree 