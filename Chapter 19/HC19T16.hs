applyWithEffects :: Applicative f 
    => (a -> b -> c)
    -> f a
    -> f b 
    -> f c
applyWithEffects f fx fy = pure f <*> fx <*> fy

demoMaybe :: IO ()
demoMaybe = do
  print $ "---------------------"  
  print $ applyWithEffects (+) (Just 2) (Just 3)    
  print $ applyWithEffects (+) (Just 2) (Nothing)   

demoIO :: IO ()
demoIO = do
  putStrLn "Enter an integer:"
  a <- read <$> getLine
  putStrLn "Enter another integer:"
  b <- read <$> getLine
  let summed = applyWithEffects (+) (pure a) (pure b)  
  r <- summed
  putStrLn $ "Sum = " ++ show r

main :: IO ()
main = do
  demoIO
  demoMaybe