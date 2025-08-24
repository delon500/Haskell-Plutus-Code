data LoggingLevel = Debug | Info | Warn | Error 
    deriving (Eq, Ord, Show, Enum, Bounded)

data Config = Config
    { loggingLevel :: LoggingLevel
    , timeout :: Int 
    , retries :: Int 
    } deriving (Eq, Show)

instance Semigroup Config where
  Config l1 t1 r1 <> Config l2 t2 r2 =
    Config
      { loggingLevel = max l1 l2  -- take the more severe/verbose level
      , timeout      = min t1 t2  -- prefer the stricter (smaller) timeout
      , retries      = max r1 r2  -- allow at least as many retries
      }

main = do 
    let cfgA = Config {loggingLevel = Info, timeout = 5000, retries = 3}
        cfgB = Config {loggingLevel = Warn, timeout = 2000, retries = 5}
        combined = cfgA <> cfgB 
    putStrLn $ "A: " ++ show cfgA 
    putStrLn $ "B: " ++ show cfgB 
    putStrLn $ "A <> B: " ++ show combined 


