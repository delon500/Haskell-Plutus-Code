import MathOps 

main = do 
    let a = 12 
        b = 8 
    
    putStrLn "===Using MathOps module===" 
    putStrLn $ show a ++ " + " ++ show b ++ " = " ++ show (add a b)
    putStrLn $ show a ++ " - " ++ show b ++ " = " ++ show (sub a b)
    putStrLn $ show a ++ " * " ++ show b ++ " = " ++ show (mul a b )
    putStrLn $ show a ++ " / " ++ show b ++ " = " ++ show (div a b )