specialBirthday :: Int -> String
specialBirthday 1 = "First birthday"
specialBirthday 18 = "You're an adult!"
specialBirthday 60 = "Finally, I can stop caring about new lingo!"
specialBirthday _ = "Happy birthday!"

main = do
    print $ specialBirthday 20
    print $ specialBirthday 13
    print $ specialBirthday 18


    


