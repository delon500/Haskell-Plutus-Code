import Control.Monad (replicateM)
import Data.Functor.Identity (Identity(..))

replicateMonad :: Int -> a -> Identity [a]
replicateMonad n x = replicateM n (Identity x)

main = do 
    let res1 = replicateMonad 5 'A'
        res2 = replicateMonad 3 (42 :: Int)

    print (runIdentity res1)  -- Output: "AAAAA"
    print (runIdentity res2)  -- Output : [42, 42, 42]