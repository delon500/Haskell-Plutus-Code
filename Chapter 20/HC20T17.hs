{-# OPTIONS_GHC -Wall #-}

import Data.Char (isUpper, isLower, isDigit)

minLen, maxLen :: Int
minLen = 8
maxLen = 64

specials :: String
specials = "!@#$%^&*()-_=+[]{};:'\",.<>/?\\|`~"

-- ---------- Helpers that return Either error-or-OK ----------
require :: Bool -> String -> Either String ()
require True  _   = Right ()
require False msg = Left msg

hasAny :: (Char -> Bool) -> String -> Bool
hasAny p = any p

hasSpecial :: String -> Bool
hasSpecial = any (`elem` specials)

-- 1) Short-circuiting validation: returns the first error it encounters
validatePassword :: String -> Either String ()
validatePassword pwd = do
  require (length pwd >= minLen) $
    "Too short: minimum " ++ show minLen ++ " characters."
  require (length pwd <= maxLen) $
    "Too long: maximum " ++ show maxLen ++ " characters."
  require (hasAny isUpper pwd) "Must contain at least one uppercase letter."
  require (hasAny isLower pwd) "Must contain at least one lowercase letter."
  require (hasAny isDigit pwd) "Must contain at least one digit."
  require (hasSpecial pwd)     ("Must contain at least one special character: " ++ specials)
  -- if we got here, everything passed
  pure ()

-- 2) Accumulating validation: collect *all* errors
--    (This doesn't rely on monadic short-circuiting; we aggregate manually.)
validatePasswordAll :: String -> Either [String] ()
validatePasswordAll pwd =
  case errors of
    [] -> Right ()
    es -> Left es
  where
    errors =
      [ "Too short: minimum " ++ show minLen ++ " characters."          | length pwd <  minLen ] ++
      [ "Too long: maximum " ++ show maxLen ++ " characters."          | length pwd >  maxLen ] ++
      [ "Must contain at least one uppercase letter."                  | not (hasAny isUpper pwd) ] ++
      [ "Must contain at least one lowercase letter."                  | not (hasAny isLower pwd) ] ++
      [ "Must contain at least one digit."                             | not (hasAny isDigit pwd) ] ++
      [ "Must contain at least one special character: " ++ specials    | not (hasSpecial pwd) ]

-- ---------- Demo ----------
demo :: String -> IO ()
demo pwd = do
  putStrLn $ "Password: " ++ show pwd
  putStrLn $ "  First error (Either String): " ++
    either (\e -> "Invalid: " ++ e) (const "Valid") (validatePassword pwd)
  putStrLn $ "  All errors (Either [String]): " ++
    either (\es -> "Invalid:\n    - " ++ unlines (map id es)) (const "Valid") (validatePasswordAll pwd)

main :: IO ()
main = do
  demo "Short1!"
  demo "alllowercase1!"
  demo "ALLUPPERCASE1!"
  demo "NoDigits!"
  demo "NoSpecial1"
  demo "GoodPass1!"
