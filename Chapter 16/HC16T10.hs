import qualified Data.Map.Strict as M 
import Data.List (foldl',sortOn)
import Data.Ord (Down(..))

charFreq :: String -> [(Char, Int)] 
charFreq = 
    M.toList . foldl' (\m c -> M.insertWith (+) c 1 m) M.empty

charFreqDesc :: String -> [(Char, Int)]
charFreqDesc = sortOn (Down . snd) . charFreq 

main = do 
    print $ charFreqDesc "hello"
    print $ charFreqDesc "mississippi"