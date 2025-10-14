import Control.Applicative (liftA3)

sumThreeApplicative 
    :: Either String Int 
    -> Either String Int
    -> Either String Int
    -> Either String Int
sumThreeApplicative = liftA3 (\x y z -> x + y + z)

main = do 
    print $ sumThreeApplicative (Right 1) (Right 2) (Right 3)
    print $ sumThreeApplicative (Right 1) (Left "Error") (Right 3)
    print $ sumThreeApplicative (Left "e1") (Right 2) (Right 3)
    print $ sumThreeApplicative (Right 1) (Left "e2") (Right 3)