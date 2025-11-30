import Control.Monad(when)
import Control.Monad.State.Strict (State, execState, modify')

step :: Char -> Char -> State Int ()
step target current = when (current == target) (modify' (+1)) 

countChars :: Char -> String -> Int
countChars target str = execState (mapM_ (step target) str) 0

main :: IO ()
main = do
    print $ countChars 'a' "banana"
    print $ countChars 'x' "banana"
    print $ countChars 'l' "Haskell"