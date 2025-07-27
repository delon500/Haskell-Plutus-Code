data Employee = Employee 
    {
        name :: String,
        experienceInYears :: Float
    } deriving (Show, Eq)


richard :: Employee
richard = Employee
    { name = "Richard"
    , experienceInYears = 7.5
    }

main = do 
    print richard