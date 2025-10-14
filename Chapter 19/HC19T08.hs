discardSecond :: Applicative f => f a -> f b -> f a 
discardSecond = (<*)

main = do 
    _ <- discardSecond (putStrLn "first") (putStrLn "second")
    x <- discardSecond (pure 42) (putStrLn "doing side-effect")
    print x 

    print(discardSecond (Just "left") (Just "right"))
    print (discardSecond (Just "left") Nothing)