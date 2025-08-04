isPalindrome :: String -> Bool
isPalindrome w = w == reverse w

main = do 
    putStrLn "Enter word: "
    input <- getLine 
    let filteredInput = filter (/= ' ') input
    if isPalindrome filteredInput
        then putStrLn "That **is** a palindrome"
        else putStrLn "That is **not** a palindrome"