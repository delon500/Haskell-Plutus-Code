isPalindrome :: String -> Bool 
isPalindrome word = word == reverse word

main = do 
    print $ isPalindrome "radar"
    print $ isPalindrome "hello"  