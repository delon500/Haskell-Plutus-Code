bmiCategory :: Float -> Float -> String
bmiCategory weight height 
    | bmi < 18.5 = "Underweight"
    | bmi >= 18.5 && bmi <= 24.9 = "Normal"
    | bmi >= 25 && bmi <= 29.9 = "Overweight"
    | otherwise = "Obese"

    where
        bmi = weight / (height * height)


main =do
    print $ bmiCategory 70 1.75
    print $ bmiCategory 90 1.8 


    