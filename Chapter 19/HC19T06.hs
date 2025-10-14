import Control.Monad (forever)
repeatEffect :: IO a -> IO b 
repeatEffect action = forever action 

main :: IO ()
main = repeatEffect $ do
  putStrLn "Say something:"
  line <- getLine
  putStrLn $ "You said: " ++ line