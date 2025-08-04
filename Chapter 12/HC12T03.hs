factorial :: Integer -> Integer
factorial 0 = 1
factorial n
  | n > 0     = n * factorial (n - 1)
  | otherwise = error "factorial: negative input"


main = do 
    putStrLn ( show 5 ++ "! = " ++ show (factorial 5))