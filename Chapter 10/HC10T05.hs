class ShowDetaild a where 
    showDetailed :: a -> String 

data User = User 
    { userId :: Int
    , name :: String
    , email :: String
    } deriving (Eq, Show)

instance ShowDetaild User where 
    showDetailed u = 
        "User ID: " ++ show (userId u) ++ "\n" ++
        "Name: " ++ name u ++ "\n" ++
        "Email: " ++ email u

userOne :: User 
userOne = 
    User {userId = 101
        , name = "Mike"
        , email = "Mike@gmail.com"
        }

main = do 
    putStrLn $ showDetailed userOne

