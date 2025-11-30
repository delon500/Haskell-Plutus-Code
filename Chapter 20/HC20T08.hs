{-# OPTIONS_GHC -Wall #-}

import Control.Applicative (Alternative(..))
import Data.Char (isDigit, isSpace)

newtype Parser a = Parser { runParser :: String -> Maybe (a, String) }

instance Functor Parser where
  fmap f (Parser p) = Parser $ \s -> do
    (a, s') <- p s
    pure (f a, s')

instance Applicative Parser where
  pure a = Parser $ \s -> Just (a, s)
  Parser pf <*> Parser pa = Parser $ \s -> do
    (f, s1) <- pf s
    (a, s2) <- pa s1
    pure (f a, s2)

instance Monad Parser where
  Parser pa >>= f = Parser $ \s -> do
    (a, s1) <- pa s
    runParser (f a) s1

instance Alternative Parser where
  empty = Parser $ const Nothing
  Parser p1 <|> Parser p2 = Parser $ \s ->
    p1 s <|> p2 s

item :: Parser Char
item = Parser $ \s -> case s of
  []     -> Nothing
  (c:cs) -> Just (c, cs)

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = do
  c <- item
  if p c then pure c else empty

char :: Char -> Parser Char
char c = satisfy (== c)

string :: String -> Parser String
string = traverse char

spaces :: Parser ()
spaces = () <$ many (satisfy isSpace)

lexeme :: Parser a -> Parser a
lexeme p = p <* spaces

symbol :: String -> Parser String
symbol = lexeme . string

digit :: Parser Char
digit = satisfy isDigit

natural :: Parser Int
natural = read <$> some digit

integer :: Parser Int
integer = lexeme $ neg <|> natural
  where
    neg = do _ <- char '-'
             n <- natural
             pure (-n)

eof :: Parser ()
eof = Parser $ \s -> case s of
  [] -> Just ((), [])
  _  -> Nothing

data Expr
  = Lit Int
  | Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr
  deriving (Eq, Show)

chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1 p op = do
  x <- p
  rest x
  where
    rest x = (do f <- op
                 y <- p
                 rest (f x y))
             <|> pure x

pFactor :: Parser Expr
pFactor =
      (Lit <$> integer)
  <|> (symbol "(" *> pExpr <* symbol ")")

pTerm :: Parser Expr
pTerm = chainl1 pFactor mulop
  where
    mulop =   (Mul <$ symbol "*")
          <|> (Div <$ symbol "/")

pExpr :: Parser Expr
pExpr = chainl1 pTerm addop
  where
    addop =   (Add <$ symbol "+")
          <|> (Sub <$ symbol "-")

parseExpr :: String -> Maybe Expr
parseExpr =
  fmap fst . runParser (spaces *> pExpr <* spaces <* eof)

eval :: Expr -> Either String Int
eval (Lit n)     = Right n
eval (Add a b)   = (+) <$> eval a <*> eval b
eval (Sub a b)   = (-) <$> eval a <*> eval b
eval (Mul a b)   = (*) <$> eval a <*> eval b
eval (Div a b)   = do
  x <- eval a
  y <- eval b
  if y == 0 then Left "division by zero"
            else Right (x `div` y)

demo :: String -> IO ()
demo s = case parseExpr s of
  Nothing -> putStrLn $ s ++ "  -- parse error"
  Just e  -> do
    putStrLn $ s ++ "  ==> AST: " ++ show e
    putStrLn $ "    eval: " ++ show (eval e)

main :: IO ()
main = do
  demo "42"
  demo "1 + 2 * 3"
  demo "(1 + 2) * 3"
  demo "10 - 3 - 2"
  demo "12 / 3 + 5 * 2"
  demo "  5 * (2 + 3)  "
  demo "7 / 0"        
