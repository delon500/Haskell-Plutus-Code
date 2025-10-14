import Control.Monad (when)

conditionalPrint :: Bool -> String -> IO ()
conditionalPrint cond msg = when cond (putStrLn msg)

main = do
    conditionalPrint True  "Shown because condition is True"
    conditionalPrint False "Not shown because condition is False"
 