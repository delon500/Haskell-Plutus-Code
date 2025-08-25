applyToMaybe :: (a -> b) -> Maybe a -> Maybe b
applyToMaybe = fmap

main :: IO ()
main = do
  print (applyToMaybe (+1) (Just 41))   -- Just 42
  print (applyToMaybe (+1) Nothing)     -- Nothing
  print (applyToMaybe show (Just True)) -- Just "True"
