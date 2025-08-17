import Control.Exception (IOException, try, evaluate, displayException)
import System.IO         (hPutStrLn, stderr)
import Text.Read         (readMaybe)

data VelocityError = FileReadError FilePath String | DistanceParseError String
  | TimeParseError String
  | NonPositiveTime Double
  | DivisionByZero
  deriving (Show)

renderError :: VelocityError -> String
renderError (FileReadError p msg)   = "File error (" ++ p ++ "): " ++ msg
renderError (DistanceParseError s)  = "Invalid distance: " ++ s
renderError (TimeParseError s)      = "Invalid time: " ++ s
renderError (NonPositiveTime t)     = "Time must be > 0, but was " ++ show t
renderError DivisionByZero          = "Division by zero."

readDistanceFromFileE :: FilePath -> IO (Either VelocityError Double)
readDistanceFromFileE path = do
  eContents <- try $ do
    txt <- readFile path
    _ <- evaluate (length txt) 
    pure txt
  case eContents of
    Left ioErr ->
      pure $ Left (FileReadError path (displayException (ioErr :: IOException)))
    Right txt ->
      case words txt of
        []       -> pure $ Left (DistanceParseError "file is empty")
        (tok:_)  -> case readMaybe tok :: Maybe Double of
                      Just d  -> pure (Right d)
                      Nothing -> pure (Left (DistanceParseError ("not a number: " ++ tok)))

parseTimeE :: String -> Either VelocityError Double
parseTimeE s =
  case readMaybe s :: Maybe Double of
    Nothing -> Left (TimeParseError ("not a number: " ++ show s))
    Just t
      | t <= 0    -> Left (NonPositiveTime t)
      | otherwise -> Right t

divideE :: Double -> Double -> Either VelocityError Double
divideE _ 0 = Left DivisionByZero
divideE x y = Right (x / y)

velocityE :: Double -> Double -> Either VelocityError Double
velocityE d t = divideE d t

main :: IO ()
main = do
  putStrLn "Enter path to file containing the distance:"
  path <- getLine

  eDist <- readDistanceFromFileE path
  case eDist of
    Left err -> hPutStrLn stderr ("Error: " ++ renderError err)
    Right dist -> do
      putStrLn $ "Distance read: " ++ show dist
      putStrLn "Enter time (> 0):"
      tStr <- getLine
      case parseTimeE tStr of
        Left err -> hPutStrLn stderr ("Error: " ++ renderError err)
        Right t  ->
          case velocityE dist t of
            Left err -> hPutStrLn stderr ("Error: " ++ renderError err)
            Right v  -> putStrLn $ "Velocity = " ++ show v ++ " (distance/time)"
