fmapTuple :: (b -> c) -> (a, b) -> (a,c)
fmapTuple = fmap

main = do 
    print $ fmapTuple (+1) (True, 41)
    print $ fmapTuple length ("name","Delon")
    print $ fmapTuple show ("ok?", False)