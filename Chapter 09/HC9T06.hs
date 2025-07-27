data Tweet = Tweet 
    { content :: String 
    , likes :: Int
    , comments :: [Tweet]
    } deriving (Show, Eq)

t1 :: Tweet
t1 = Tweet
    { content = "Hello, Haskell"
    , likes = 5
    , comments = [reply1, reply2]
    }

reply1, reply2 :: Tweet 
reply1 = Tweet 
    { content = "Nice tweet"
    , likes = 2
    , comments = []
    }

reply2 = Tweet
  { content  = "I agree!"
  , likes    = 3
  , comments =
      [ Tweet
          { content  = "Glad we all agree "
          , likes    = 1
          , comments = []
          }
      ]
  }

main :: IO ()
main = do 
    print t1