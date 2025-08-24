data Severity = Low | Medium | High | Critical 
    deriving (Eq, Ord, Show, Enum, Bounded)

instance Semigroup Severity where 
    (<>) = max 

instance Monoid Severity where 
    mempty = Low 
    mappend = (<>)

maxSeverity :: [Severity] -> Severity 
maxSeverity = mconcat

main = do 
    print (maxSeverity [Low, Medium, High])
    print (maxSeverity [Low, Critical, Medium])
    print (maxSeverity [])