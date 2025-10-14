applyEffects :: (IO Int, IO Int) -> IO Int
applyEffects (mx, my) =
  (,) <$> mx <*> my >>= \(x, y) -> do
    putStrLn $ "First : " ++ show x
    putStrLn $ "Second: " ++ show y
    let s = x + y
    putStrLn $ "Sum   : " ++ show s
    pure s 

main :: IO ()
main = do
  let a = pure 7
      b = pure 35
  _ <- applyEffects (a, b)
  pure ()