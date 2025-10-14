import Control.Applicative (liftA2)

combineResults :: (a -> b -> c) -> Either e a -> Either e b -> Either e c
combineResults = liftA2

right5 :: Either String Int
right5 = Right 5

right3 :: Either String Int
right3 = Right 3

main = do 
    print $ combineResults (,) right5 right3  
    print $ combineResults (+) right5 right5
    