import Data.List (sort, sortOn)
import Data.Ord (Down(..))

extractPlayers :: [(String, Int)] -> [String]
extractPlayers = map fst

sortByScore :: [(String ,Int)] -> [(String ,Int)]
sortByScore = sortOn (Down . snd)

topThree :: [(String, Int)] -> [(String, Int)]
topThree = take 3 . sortByScore

getTopThreePlayers :: [(String, Int)] -> [String]
getTopThreePlayers = extractPlayers . topThree


main = do
    print $ getTopThreePlayers [("Tony", 15),("Josh", 4), ("Tim", 74), ("Lee", 41)]