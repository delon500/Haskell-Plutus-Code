import Data.Monoid(Sum(..))
import GHC.IO.Device (IODevice(tell))

data Tree a = Empty | Node (Tree a) a (Tree a)
  deriving (Show)

newtype MyWriter w a = MyWriter { runMyWriter :: (w, a) }

instance Functor (MyWriter w) where
  fmap f (MyWriter (w, a)) = MyWriter (w, f a)

instance Monoid w => Applicative (MyWriter w) where
    pure a = MyWriter (mempty, a)
    (<*>) :: Monoid w => MyWriter w (a -> b) -> MyWriter w a -> MyWriter w b
    MyWriter (w1, f) <*> MyWriter (w2, a) = MyWriter (w1 <> w2, f a)

instance Monoid w => Monad (MyWriter w) where
    MyWriter (w1, a) >>= f =
        let MyWriter (w2, b) = f a
        in MyWriter (w1 <> w2, b)

tellW :: w -> MyWriter w ()
tellW w = MyWriter (w, ())

execMyWriter :: MyWriter w a -> w
execMyWriter = fst . runMyWriter

sumTreeW :: (Num a) => Tree a -> MyWriter (Sum a) ()
sumTreeW Empty = pure ()
sumTreeW (Node left val right) = do
    sumTreeW left
    tellW (Sum val)
    sumTreeW right

treeSum :: Num a => Tree a -> a
treeSum tree = getSum $ execMyWriter (sumTreeW tree)

exampleTree :: Tree Int
exampleTree = 
    Node
        (Node (Node Empty 2 Empty) 1 (Node Empty 3 Empty))
        4
        (Node Empty 5 (Node Empty 7 Empty))

main = do 
    print exampleTree
    putStrLn $ "Sum = " ++ show (treeSum exampleTree)