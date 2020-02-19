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
