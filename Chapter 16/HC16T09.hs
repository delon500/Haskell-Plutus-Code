import qualified Data.Set as S

dedupOrd :: Ord a => [a] -> [a]
dedupOrd = go S.empty
    where 
        go _ [] = []
        go seen (x:xs) 
            | x `S.member` seen = go seen xs
            | otherwise = x:go (S.insert x seen) xs

main = do
  print $ dedupOrd [3,1,3,2,1,4,2]
  print $ dedupOrd [5]
  print $ dedupOrd "mississippi"
  print $ dedupOrd [4,7,4,6,2,6]