fibonacciSeq :: Int -> Int
fibonacciSeq 0 = 0
fibonacciSeq 1 = 1
fibonacciSeq n = fibonacciSeq(n - 1) + fibonacciSeq(n - 2) 

main = do
    print $ fibonacciSeq 1
    print $ fibonacciSeq 5
    print $ fibonacciSeq 0
    print $ fibonacciSeq 10