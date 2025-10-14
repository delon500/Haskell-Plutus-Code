import Control.Applicative

addThreeApplicative :: Maybe Int -> Maybe Int -> Maybe Int -> Maybe Int 
addThreeApplicative = liftA3 (\x y z -> x + y + z)

main = do 
    print $ addThreeApplicative (Just 1) (Just 2) (Just 4)
    print $ addThreeApplicative (Just 1) Nothing (Just 4)