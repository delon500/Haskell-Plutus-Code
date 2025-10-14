whenApplicative :: Applicative f => Bool -> f () -> f ()
whenApplicative cond act = 
    if cond then act else pure ()

main = do
    whenApplicative True  (putStrLn "Shown (cond = True)")
    whenApplicative False (putStrLn "Hidden (cond = False)")
    putStrLn "Done."