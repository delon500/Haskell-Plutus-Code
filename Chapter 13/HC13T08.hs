import qualified Data.Map.Strict as M
import qualified Data.Set as S

exampleMap :: M.Map Int String 
exampleMap = M.fromList [(1, "one"), (2, "two"), (3, "three")]

exampleSet :: S.Set Int 
exampleSet = S.fromList [1, 3, 5, 7]

main = do 
    putStrLn "== Data.Map operatons =="
    putStrLn $ "M.size exampleMap = " ++ show (M.size exampleMap)
    putStrLn $ "M.member 2 exampleMap =" ++ show (M.member 2 exampleMap)
    putStrLn $ "M.empty :: M.Map Int String = " ++ show (M.empty :: M.Map Int String)

    putStrLn "\n == Data.Set operations =="
    putStrLn $ "S.size exampleSet = " ++ show (S.size exampleSet)
    putStrLn $ "S.member 3 exampleSet = " ++ show (S.member 2 exampleSet)
    putStrLn $ "S.empty :: Set Int = " ++ show (S.empty :: S.Set Int)