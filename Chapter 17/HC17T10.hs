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
      { loggingLevel = max l1 l2 
      , timeout      = min t1 t2  
      , retries      = max r1 r2 
      }

instance Monoid Config where 
    mempty = Config {loggingLevel = minBound
                    , timeout = maxBound
                    , retries = 0
                    }
    mappend = (<>)

main = do 
    let a = Config Info 5000 3 
        b = Config Warn 2000 5 
    print (mempty <> a) 
    print (a <> mempty)
    print (a <> b) 
    print (mconcat [mempty,a,b])