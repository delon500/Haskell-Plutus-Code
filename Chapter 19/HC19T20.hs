import Control.Monad (forever)

replicateForever :: IO a -> IO b 
replicateForever = forever 

main = do 
    putStrLn "Say something:"
    line <- getLine
    putStrLn $ "You said: " ++ line

