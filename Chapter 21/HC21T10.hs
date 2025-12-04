{-# OPTIONS_GHC -Wall #-}
module Main where

-- Minimal State monad
newtype State s a = MkState { runState :: s -> (a, s) }

instance Functor (State s) where
  fmap f (MkState sa) = MkState $ \s -> let (a,s') = sa s in (f a, s')

instance Applicative (State s) where
  pure a = MkState $ \s -> (a, s)
  MkState sf <*> MkState sa = MkState $ \s ->
    let (f,s1) = sf s
        (a,s2) = sa s1
    in (f a, s2)

instance Monad (State s) where
  MkState sa >>= k = MkState $ \s ->
    let (a,s1)    = sa s
        MkState b = k a
    in b s1

-- Primitives
get :: State s s
get = MkState $ \s -> (s, s)

put :: s -> State s ()
put s = MkState $ \_ -> ((), s)

modify :: (s -> s) -> State s ()
modify f = MkState $ \s -> ((), f s)

-- ========== Vending Machine Core ==========

data VendingState = MkVendingState
  { items  :: Int   -- how many items left
  , credit :: Int   -- user’s inserted credit (in cents or any unit)
  } deriving (Show)

itemPrice :: Int
itemPrice = 7  -- set the price (change as you like)

-- Insert a coin amount
insertCoin :: Int -> State VendingState ()
insertCoin amt = modify (\st -> st { credit = credit st + amt })

-- Attempt to vend one item
vend :: State VendingState String
vend = do
  st <- get
  if items st <= 0
     then pure "Sold out."
  else if credit st < itemPrice
     then pure ("Insufficient credit. Need " ++ show (itemPrice - credit st) ++ " more.")
  else do
     -- dispense: decrement items, deduct price
     put st { items = items st - 1, credit = credit st - itemPrice }
     pure "Enjoy your item!"

-- Return all remaining change and zero credit
getChange :: State VendingState Int
getChange = do
  st <- get
  let c = credit st
  put st { credit = 0 }
  pure c

-- A sample sequence: insert coins, vend, then return change
vendingSequence :: State VendingState String
vendingSequence = do
  insertCoin 5
  insertCoin 5
  msg <- vend
  ch  <- getChange
  pure (msg ++ " Change returned: " ++ show ch)

-- Demo
main :: IO ()
main = do
  let start = MkVendingState { items = 2, credit = 0 }
      (resultMsg, endState) = runState vendingSequence start
  putStrLn $ "Result : " ++ resultMsg
  putStrLn $ "EndState: " ++ show endState
