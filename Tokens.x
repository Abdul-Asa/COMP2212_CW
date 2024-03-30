{
module Tokens where
}

%wrapper "posn"

$digit = 0-9     -- digits
$alpha = [a-zA-Z]    -- alphabetic characters

tokens :-
  $white+       ;
  "--".*        { \p s -> TokenComment p s };
  "LOAD"        { \p s -> TokenLoad p };
  "SELECT"      { \p s -> TokenSelect p };
  "FROM"        { \p s -> TokenFrom p };
  "WHERE"       { \p s -> TokenWhere p };
  "OR"          { \p s -> TokenOr p };
  "<="          { \p s -> TokenLtEq p };
  ">"           { \p s -> TokenGt p };
  "<"           { \p s -> TokenLt p };
  ">="          { \p s -> TokenGtEq p };
  "!="          { \p s -> TokenNotEq p };
  "="           { \p s -> TokenEq p };
  $digit+       { \p s -> TokenInt p (read s) };
  "+"           { \p s -> TokenPlus p };
  "-"           { \p s -> TokenMinus p };
  "*"           { \p s -> TokenTimes p };
  "/"           { \p s -> TokenDiv p };
  "^"           { \p s -> TokenExp p };
  "("           { \p s -> TokenLParen p };
  ")"           { \p s -> TokenRParen p };
  $alpha[$alpha $digit \_ \']*  { \p s -> TokenVar p s };

{
data Token =
  TokenComment AlexPosn String |
  TokenLoad AlexPosn           |
  TokenSelect AlexPosn         |
  TokenFrom AlexPosn           |
  TokenWhere AlexPosn          |
  TokenOr AlexPosn             |
  TokenLtEq AlexPosn           |  
  TokenGtEq AlexPosn           |
  TokenGt AlexPosn             |
  TokenLt AlexPosn             |
  TokenNotEq AlexPosn          |
  TokenInt AlexPosn Int        |
  TokenVar AlexPosn String     |
  TokenEq AlexPosn             |
  TokenPlus AlexPosn           |
  TokenMinus AlexPosn          |
  TokenTimes AlexPosn          |
  TokenDiv AlexPosn            |
  TokenExp AlexPosn            |
  TokenLParen AlexPosn         |
  TokenRParen AlexPosn         
  deriving (Eq,Show)

tokenPosn :: Token -> String
tokenPosn (TokenComment (AlexPn _ l c) _) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLoad (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenSelect (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenFrom (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenWhere (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenOr (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLtEq (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenInt (AlexPn _ l c) _) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenVar (AlexPn _ l c) _) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenEq (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenPlus (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenMinus (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenTimes (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenDiv (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenExp (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLParen (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenRParen (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGt (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLt (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGtEq (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenNotEq (AlexPn _ l c)) = show(l) ++ ":" ++ show(c)
}
