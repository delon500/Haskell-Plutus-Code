{-
- We derive Ord, so Low < Medium < High < Critical (based on constructor order).
- Defining (<>) = max means combining severities always returns the higher one.
- max is associative, so the Semigroup law holds.
-}

data Severity = Low | Medium | High | Critical 
    deriving (Eq, Ord, Show, Enum, Bounded) 

instance Semigroup Severity where 
    (<>) = max

main = do 
    print (Low <> Medium)
    print (High <> Medium)
    print (Medium <> Critical)
    print (Low <> Low <> High) 