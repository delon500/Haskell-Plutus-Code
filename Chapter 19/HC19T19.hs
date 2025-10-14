import Control.Applicative (liftA2)

sequenceApplicative :: [Maybe a] -> Maybe [a]
sequenceApplicative = foldr (liftA2 (:)) (pure [])


main = do 
    print $ sequenceApplicative [Just 3, Just 2, Just 1]
    print $ sequenceApplicative [Just 'a', Nothing, Just 'b']
    print $ sequenceApplicative ([] :: [Maybe Int]) 