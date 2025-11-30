import Control.Monad (forM)
import Text.Read (readMaybe)

mapMFilter :: Monad m => (a -> m (Maybe b)) -> [a] -> m [b]
mapMFilter f = go
  where
    go []     = pure []
    go (x:xs) = do
      r  <- f x           
      rs <- go xs        
      pure $ case r of
        Just y  -> y : rs
        Nothing -> rs 

keepEvenParsed :: String -> IO (Maybe Int)
keepEvenParsed s = do
  putStrLn $ "Reading: " ++ s
  case readMaybe s :: Maybe Int of
    Nothing -> do
      putStrLn "  parse failed -> drop"
      pure Nothing
    Just n ->
      if even n then do
        putStrLn "  even -> keep"
        pure (Just n)
      else do
        putStrLn "  odd -> drop"
        pure Nothing

nonNegSquare :: Int -> Maybe (Maybe Int)
nonNegSquare n
  | n < 0     = Just Nothing
  | otherwise = Just (Just (n*n)) 

main = do 
    putStrLn "Demo of mapMFilter with IO and Maybe"
    results1 <- mapMFilter keepEvenParsed ["10", "15", "abc", "22", "-4", "7"]
    putStrLn $ "Filtered even parsed numbers: " ++ show results1
    
    putStrLn "\nDemo of mapMFilter with Maybe and Maybe"
    let results2 = mapMFilter nonNegSquare [4, -1, 3, 0, -5, 2]
    putStrLn $ "Filtered non-negative squares: " ++ show results2