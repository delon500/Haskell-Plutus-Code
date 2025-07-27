data Tweet = Tweet
    { content :: String 
    , likes :: Int
    , comments :: [Tweet]
    } deriving (Show, Eq)

engagement :: Tweet -> Int 
engagement (Tweet _ likeCount replies) =
    likeCount + sum (map engagement replies)

replyA, replyB, nestedReply :: Tweet
nestedReply = Tweet
    { content = "Nested"
    , likes = 1
    , comments = []
    }

replyA = Tweet
    { content = "First reply"
    , likes = 2
    , comments = []
    }

replyB = Tweet
    { content = "Second reply"
    , likes = 3
    , comments = []
    } 

main = do 
    let original = Tweet { content = "Original tweet"
        , likes = 5
        , comments = [replyA, replyB]
        }
    putStrLn $ "Engagement: " ++ show (engagement original)