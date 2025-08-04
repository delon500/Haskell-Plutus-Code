fibonacci :: Integer -> Integer 
fibonacci 0 = 0
fibonacci 1 = 1 
fibonacci n = fibonacci(n - 1) + fibonacci(n - 2)

main = do 
    let firstTen = map fibonacci [0..9]
    putStrLn "First 10 Fibonacci numbers:"
    print firstTen