import Text.Read (readMaybe)
import Data.List (intercalate)

divideEither :: (Eq a, Fractional a) => a -> a -> Either String a
divideEither _ 0 = Left "Division by zero: denominator must be non-zero."
divideEither x y = Right (x / y)

divideEitherRF :: RealFloat a => a -> a -> Either String a
divideEitherRF _ 0 = Left "Division by zero: denominator must be non-zero."
divideEitherRF x y =
  let r = x / y
  in if  isNaN r      then Left "Result is NaN (not a number)."
     else if isInfinite r then Left "Result is infinite (overflow / tiny denominator)."
     else Right r

parseAndDivide :: String -> String -> Either String Double
parseAndDivide sx sy = do
  x <- maybe (Left $ "Invalid numerator: "   ++ show sx) (Right) (readMaybe sx :: Maybe Double)
  y <- maybe (Left $ "Invalid denominator: " ++ show sy) (Right) (readMaybe sy :: Maybe Double)
  divideEitherRF x y

showEither :: (Show a) => Either String a -> String
showEither (Left e)  = "Error: "  ++ e
showEither (Right v) = "Result: " ++ show v

main :: IO ()
main = do
  putStrLn "=== divideEither (numbers) ==="
  putStrLn $ showEither (divideEither 10.0 2.0)        
  putStrLn $ showEither (divideEither 7.0  0.0)        

  putStrLn "\n=== parseAndDivide (strings) ==="
  putStrLn $ showEither (parseAndDivide "7"   "2.5")   
  putStrLn $ showEither (parseAndDivide "foo" "2")     
  putStrLn $ showEither (parseAndDivide "7"   "0")
