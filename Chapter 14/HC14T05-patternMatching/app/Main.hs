module Main where

data Result a 
    = Success a
    | Failure String
    deriving (Show, Eq)

describe :: Show a => Result a -> String
describe r@(Success x) =
  "Got a Success with " ++ show x ++ " (whole value was " ++ show r ++ ")"
describe r@(Failure msg)
  | length msg > 10 =
      "Failure (long message: " ++ take 10 msg ++ "...) ; whole=" ++ show r
  | otherwise =
      "Failure: " ++ msg ++ " ; whole=" ++ show r


firstTwo :: [a] -> String
firstTwo xs@(x:y:_) = "First two exist; whole list was length " ++ show (length xs)
firstTwo _          = "First two do not exist"


main :: IO ()
main = do 
    let a = Success (42 :: Int)
        b = Failure "Ooops" :: Result Int 
        c = Failure "Something went a bit wrong here" :: Result Int
    
    putStrLn (describe a)
    putStrLn (describe b)
    putStrLn (describe c)

    putStrLn (firstTwo [1,2,3])
    putStrLn (firstTwo ([] :: [Int]))
