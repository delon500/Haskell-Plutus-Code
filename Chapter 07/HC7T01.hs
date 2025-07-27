data Color
    = Red
    | Green
    | Blue
    deriving Show

instance Eq Color where
    Red == Red = True
    Green == Green = True
    Blue == Blue = True
    _ == _ = False
main = do
    print $ Red == Red
    print $ Red == Green
    print $ Blue == Blue
    print $ Green == Blue