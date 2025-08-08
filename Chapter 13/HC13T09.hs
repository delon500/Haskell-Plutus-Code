module Main where

import qualified Data.Map.Strict as Dict 
import qualified Data.Set        as Bag   

sizesAndMembership
  :: (Ord k, Num k)
  => Dict.Map k v   
  -> Bag.Set k      
  -> (Int, Int, Bool, Bool)
sizesAndMembership mp st =
  ( Dict.size mp           
  , Bag.size  st           
  , Dict.member 42 mp
  , Bag.member  42 st
  )

main :: IO ()
main = do
  let exampleMap = Dict.fromList [(10,"ten"), (42,"answer"), (7,"seven")]
      exampleSet = Bag.fromList [1,2,42,99]

      (mapSz,setSz,keyInMap,valInSet) = sizesAndMembership exampleMap exampleSet

  putStrLn $ "Map size = "  ++ show mapSz
  putStrLn $ "Set size = "  ++ show setSz
  putStrLn $ "Does Map contain key 42?  "   ++ show keyInMap
  putStrLn $ "Does Set contain element 42? " ++ show valInSet
