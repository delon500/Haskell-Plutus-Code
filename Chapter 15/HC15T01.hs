import Control.Exception (IOException, try, evaluate)
import System.IO         (hPutStrLn, stderr)
import Text.Read         (readMaybe)

readDistanceFromFile :: FilePath -> IO (Either String Double)
readDistanceFromFile path = do
  e <- try $ do
    contents <- readFile path
    _ <- evaluate (length contents)
    pure contents
  case e of
    Left ioErr ->
      pure (Left $ "I/O error while reading file: " ++ show (ioErr :: IOException))
    Right contents ->
      case words contents of
        (tok:_) ->
          case readMaybe tok :: Maybe Double of
            Just d  -> pure (Right d)
            Nothing -> pure (Left "Parse error: first token is not a number.")
        [] -> pure (Left "The file is empty (no number found).")

promptPositiveDouble :: String -> IO Double
promptPositiveDouble label = do
  putStrLn label
  s <- getLine
  case readMaybe s :: Maybe Double of
    Just t | t > 0 -> pure t
    _ -> do
      putStrLn "Please enter a positive number (e.g., 3.5)."
      promptPositiveDouble label

main :: IO ()
main = do
  putStrLn "Enter path to file containing the distance (first token):"
  path <- getLine

  eDist <- readDistanceFromFile path
  case eDist of
    Left err -> hPutStrLn stderr $ "Error: " ++ err
    Right distance -> do
      putStrLn $ "Distance read from file: " ++ show distance
      time <- promptPositiveDouble "Enter time (> 0):"
      let velocity = distance / time
      putStrLn $ "Velocity = " ++ show velocity ++ " (distance/time)"
