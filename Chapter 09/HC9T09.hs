data Sequence a 
    = End
    | Node a (Sequence a)
    deriving (Show, Eq)

elemSeq :: Eq a => a -> Sequence a -> Bool
elemSeq _ End = False
elemSeq x (Node y rest) = (x == y) || elemSeq x rest

exampleSeq :: Sequence Int
exampleSeq = Node 1 (Node 2 (Node 3 End))

main = do 
    print $ elemSeq 2 exampleSeq
    print $ elemSeq 3 exampleSeq
    print $ elemSeq 4 exampleSeq