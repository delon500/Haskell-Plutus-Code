
data Severity = Low | Medium | High | Critical
    deriving (Eq, Ord, Show, Enum, Bounded)

instance Semigroup Severity where 
    (<>) = max

instance Monoid Severity where 
    mempty = Low
    mappend = (<>)

main = do 
    print (Medium <> High)
    print (mempty <> High)
    print (Medium <> mempty)
    print (mconcat [Low, Medium, Low])
    print (mconcat [Low,Critical, Medium])
    print (mconcat [] :: Severity)