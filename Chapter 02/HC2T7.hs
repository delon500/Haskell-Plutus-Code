main :: IO()
main = do
    let a = True
    let b = False
    
    putStrLn ("Bool Expressions &&: " ++ show (a && a))
    putStrLn ("Bool Expressiona ||: " ++ show (b || b))
    putStrLn ("Bool Expressiona not: " ++ show (not (a && b)))
    