import Control.Exception (Exception, throwIO, try)
import Data.Char (isSpace, toLower)
import System.IO (hPutStrLn, stderr)

data TrafficLight = Red | Yellow | Green
  deriving (Show, Eq)

data Action = Stop | PrepareToStop | Go
  deriving (Show, Eq)

data TrafficLightError
  = InvalidColor String           
  deriving (Show)
instance Exception TrafficLightError

trim :: String -> String
trim = f . f where f = reverse . dropWhile isSpace

parseTrafficLightIO :: String -> IO TrafficLight
parseTrafficLightIO raw =
  case map toLower (trim raw) of
    "red"    -> pure Red
    "r"      -> pure Red
    "yellow" -> pure Yellow
    "amber"  -> pure Yellow
    "y"      -> pure Yellow
    "green"  -> pure Green
    "g"      -> pure Green
    bad      -> throwIO (InvalidColor bad)   

react :: TrafficLight -> Action
react Red    = Stop
react Yellow = PrepareToStop
react Green  = Go

main :: IO ()
main = do
  putStrLn "Enter traffic light color (red / yellow / green):"
  raw <- getLine

  eTL <- try (parseTrafficLightIO raw) :: IO (Either TrafficLightError TrafficLight)
  case eTL of
    Left err -> do
      hPutStrLn stderr $ "Traffic light error: " ++ show err
      hPutStrLn stderr "Falling back to a safe action: Stop."
      print Stop
    Right tl -> do
      putStrLn $ "Parsed: " ++ show tl
      print (react tl)
