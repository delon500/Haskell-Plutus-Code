import Control.Monad (replicateM)

replicateEffect :: Int -> IO a -> IO [a]
replicateEffect n action = replicateM n action

main = do
    putStrLn "Type three lines:"
    lines3 <- replicateEffect 3 getLine
    putStrLn "You entered:"
    mapM_ putStrLn lines3