gradeComment :: Int -> String
gradeComment grade 
    | grade >= 90 && grade <= 100 = "Excellent!"
    | grade >= 70 && grade <= 89 = "Good job!"
    | grade >= 50 && grade <= 69 = "You passed."
    | grade >= 0 && grade <= 49 = "Better luck next time."
    | otherwise = "Invalid grade"


main = do
    putStrLn (gradeComment 93)
    putStrLn (gradeComment (-1))
    putStrLn (gradeComment 78)
    putStrLn (gradeComment 66)
    putStrLn (gradeComment 12)

    
