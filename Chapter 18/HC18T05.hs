data Either' e a = Left' e | Right' a 
    deriving (Eq, Show)

instance Functor (Either' e) where 
    fmap _ (Left' e) = Left' e 
    fmap f (Right' a) = Right' (f a)

main :: IO ()
main = do 
    let ok = Right' (10 :: Int) :: Either' String Int 
        err = Left' "boom" :: Either' String Int

    print (fmap (+1) ok) 
    print (fmap (+1) err)

    print (fmap show ok)