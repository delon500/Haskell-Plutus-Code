import Data.Char (toLower,isSpace)
import Text.Read (readMaybe)
import Data.Binary.Get (label)

data TrafficLight = Red | Yellow | Green 
    deriving (Show, Eq)

data Action = Stop | PrepareToStop | Go | CautiousGo 
    deriving (Show, Eq)

data CarContext = CarContext 
    { speed :: Double
    , distanceToStopLine :: Double
    } deriving (Show)

trim :: String -> String 
trim = f . f where 
    f = reverse . dropWhile isSpace

parseTrafficLight :: String -> Maybe TrafficLight 
parseTrafficLight s = case map toLower (trim s) of 
    "red" -> Just Red 
    "r" -> Just Red
    "yellow" -> Just Yellow
    "amber" -> Just Yellow
    "y" -> Just Yellow
    "green" -> Just Green
    "g" -> Just Green
    _ -> Nothing

prompt :: String -> IO String 
prompt label = putStrLn label >> getLine

promptTrafficLight :: IO TrafficLight 
promptTrafficLight = do 
    s <- prompt "Enter traffic light color (red / yellow / green):"
    case parseTrafficLight s of 
        Just tl -> return tl 
        Nothing -> do 
            putStrLn "Sorry, I didn't understand that color"
            promptTrafficLight

promptNonNeg :: String -> IO Double
promptNonNeg label = do 
    s <- prompt label 
    case readMaybe s :: Maybe Double of 
        Just x | x >= 0 -> pure x
        _ -> do 
            putStrLn "Please enter a non-negative number (e.g 12.5)"
            promptNonNeg label 

reactBasic ::TrafficLight -> Action 
reactBasic Red = Stop 
reactBasic Green = Go 
reactBasic Yellow = PrepareToStop

canStopSafely :: CarContext -> Bool 
canStopSafely (CarContext v d) = 
    let reactionTime = 0.7 
        decel = 6.0 
        reactionDist = v * reactionTime
        breakingDist = v * v / (2 * decel)
        required = reactionDist + breakingDist
    in required <= d

reactContext :: CarContext -> TrafficLight -> Action 
reactContext _ Red = Stop
reactContext _ Green = Go
reactContext ctx Yellow = 
    if canStopSafely ctx then Stop else CautiousGo

main = do 
    tl <- promptTrafficLight 
    v <- promptNonNeg "Enter your speed (m/s):"
    d <- promptNonNeg "Enter the distance to the traffic light (m):" 

    let ctx = CarContext v d
        basic = reactBasic tl
        context = reactContext ctx tl 

    putStrLn "\n=== Decision ==="
    putStrLn $ "Basic: " ++ show basic
    putStrLn $ "Context-aware " ++ show context