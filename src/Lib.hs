module Lib
    ( parseInput
    ) where

import System.Environment
import System.Exit

parseInput = getArgs >>= parse >>= putStr . parseAll -- . tokenToString . splitTokens

parse ["-h"] = usage   >> exit
parse ["-v"] = version >> exit
parse []     = getContents
parse fs     = concat `fmap` mapM readFile fs

usage   = putStrLn "Usage: lexical [-vh] file"
version = putStrLn "Haskell C- lexical analyser 0.1"
exit    = exitWith ExitSuccess
die     = exitWith (ExitFailure 1)

data Token = TOKEN_MAIN | TOKEN_INT | TOKEN_OTHER | TOKEN_OPENBRACES | TOKEN_CLOSINGBRACES | TOKEN_OPENPAREN | TOKEN_CLOSINGPAREN | TOKEN_RETURN | TOKEN_SEMICOLON
    deriving (Eq)

parseAll :: String -> String
parseAll [] = []
parseAll a = concatTokens (prepare(words (a)))

prepare :: [String] -> [String]
prepare [] = []
prepare (a:as) = [a, prepare as]

concatTokens :: [String] -> String
concatTokens [] = []
concatTokens (a:as) = tokenToString (splitTokens(a)) ++ concatTokens as

splitTokens :: String -> Token
splitTokens "int" = TOKEN_INT
splitTokens "main" = TOKEN_MAIN
splitTokens "{" = TOKEN_OPENBRACES
splitTokens "}" = TOKEN_CLOSINGBRACES
splitTokens "(" = TOKEN_OPENPAREN
splitTokens ")" = TOKEN_CLOSINGPAREN
splitTokens "return" = TOKEN_RETURN
splitTokens ";" = TOKEN_SEMICOLON
splitTokens _ = TOKEN_OTHER

tokenToString :: Token -> String
tokenToString b
    | b == TOKEN_INT = "%INT%"
    | b == TOKEN_MAIN = "%MAIN%"
    | b == TOKEN_OPENBRACES = "%OPENBRACES"
    | b == TOKEN_CLOSINGBRACES = "%CLOSINGBRACES%"
    | b == TOKEN_OPENPAREN = "%OPENPAREN%"
    | b == TOKEN_CLOSINGPAREN = "%CLOSINGPAREN%"
    | b == TOKEN_RETURN = "%RETURN%"
    | b == TOKEN_SEMICOLON = "%SEMICOLON%"
    | otherwise = "%OTHER%"
