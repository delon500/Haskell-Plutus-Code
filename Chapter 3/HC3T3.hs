import Text.Printf (printf)

rgbToHex :: (Int, Int, Int) -> String
rgbToHex (r, g, b) =
    let 
        red = printf "%02X" r
        green = printf "%02X" g
        blue = printf "%02X" b
    in
        "#" ++ red ++ green ++ blue

main :: IO()
main = do
    print $ rgbToHex (255, 0, 127)
    print $ rgbToHex (0, 255, 64)

    