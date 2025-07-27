specialBirthday :: Int -> String
specialBirthday 1 = "First birthday"
specialBirthday 18 = "You're an adult!"
specialBirthday 60 = "Finally, I can stop caring about new lingo!"

main = do
    print $ specialBirthday 18
    print $ specialBirthday 1


