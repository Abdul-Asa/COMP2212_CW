import Control.Exception
import NotSqlTokens
import System.Environment
import System.IO

main :: IO ()
main = catch main' noParse

main' = do
  (fileName : _) <- getArgs
  sourceText <- readFile fileName
  putStrLn ("Lexing : " ++ sourceText)
  let lexedProg = alexScanTokens sourceText
  putStrLn ("Lexed as " ++ show lexedProg)

noParse :: ErrorCall -> IO ()
noParse e = do
  let err = show e
  hPutStr stderr err
  return ()