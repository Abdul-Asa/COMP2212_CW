{
module NotSqlTokens where
}

%wrapper "posn"

$digit = 0-9         -- digits
$alpha = [a-zA-Z]    -- alphabetic characters
$sym = [_]

tokens :-
$white+              ; -- Whitespaces
"--".*               ; -- Single line comments
"LOAD"               { tok (\p s -> TokenLoad p) }
"SELECT"             { tok (\p s -> TokenSelect p) }
"FROM"               { tok (\p s -> TokenFrom p) }
"WHERE"              { tok (\p s -> TokenWhere p) }
"*"                  { tok (\p s -> TokenStar p) }
","                  { tok (\p s -> TokenComma p) }
"="                  { tok (\p s -> TokenEq p) }
"<>"                 { tok (\p s -> TokenNeq p) }
"<"                  { tok (\p s -> TokenLt p) }
">"                  { tok (\p s -> TokenGt p) }
"<="                 { tok (\p s -> TokenLe p) }
">="                 { tok (\p s -> TokenGe p) }
"AND"                { tok (\p s -> TokenAnd p) }
"OR"                 { tok (\p s -> TokenOr p) }
"TRUE"               { tok (\p s -> TokenTrue p) }
"FALSE"              { tok (\p s -> TokenFalse p) }
$digit+              { tok (\p s -> TokenInt p (read s)) }
\"[^\"]*\"           { tok (\p s -> TokenString p s) } -- Simple string token
$alpha[$alpha $digit $sym]*  { tok (\p s -> TokenIdentifier p s) }

{
-- Each action has type :: AlexPosn -> String -> NotSqlToken

-- Helper function
tok f p s = f p s

-- The token type:
data NotSqlToken =
    TokenLoad AlexPosn          |
    TokenSelect AlexPosn        |
    TokenFrom AlexPosn          |
    TokenWhere AlexPosn         |
    TokenStar AlexPosn          |
    TokenComma AlexPosn         |
    TokenEq AlexPosn            |
    TokenNeq AlexPosn           |
    TokenLt AlexPosn            |
    TokenGt AlexPosn            |
    TokenLe AlexPosn            |
    TokenGe AlexPosn            |
    TokenAnd AlexPosn           |
    TokenOr AlexPosn            |
    TokenTrue AlexPosn          |
    TokenFalse AlexPosn         |
    TokenInt AlexPosn Int       |
    TokenString AlexPosn String |
    TokenIdentifier AlexPosn String
    deriving (Eq, Show)

tokenPosn :: NotSqlToken -> String
tokenPosn (TokenLoad (AlexPn _ l c))          = show(l) ++ ":" ++ show(c)
tokenPosn (TokenSelect (AlexPn _ l c))        = show(l) ++ ":" ++ show(c)
tokenPosn (TokenFrom (AlexPn _ l c))          = show(l) ++ ":" ++ show(c)
tokenPosn (TokenWhere (AlexPn _ l c))         = show(l) ++ ":" ++ show(c)
tokenPosn (TokenStar (AlexPn _ l c))          = show(l) ++ ":" ++ show(c)
tokenPosn (TokenComma (AlexPn _ l c))         = show(l) ++ ":" ++ show(c)
tokenPosn (TokenEq (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenNeq (AlexPn _ l c))           = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLt (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGt (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLe (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGe (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenAnd (AlexPn _ l c))           = show(l) ++ ":" ++ show(c)
tokenPosn (TokenOr (AlexPn _ l c))            = show(l) ++ ":" ++ show(c)
tokenPosn (TokenTrue (AlexPn _ l c))          = show(l) ++ ":" ++ show(c)
tokenPosn (TokenFalse (AlexPn _ l c))         = show(l) ++ ":" ++ show(c)
tokenPosn (TokenInt (AlexPn _ l c) _)         = show(l) ++ ":" ++ show(c)
tokenPosn (TokenString (AlexPn _ l c) _)      = show(l) ++ ":" ++ show(c)
tokenPosn (TokenIdentifier (AlexPn _ l c) _)  = show(l) ++ ":" ++ show(c)
}
