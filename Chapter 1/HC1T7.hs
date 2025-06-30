fToC :: Float -> Float
fToC f = (f - 32) * 5/9

main = do
    print $ fToC 32
    print $ fToC 45
    print $ fToC 30