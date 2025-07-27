data Sequence a 
    = End 
    | Node a (Sequence a)
    deriving (Show, Eq)

seqNode :: Sequence Int 
seqNode = Node 1 (Node 2 (Node 3 End))