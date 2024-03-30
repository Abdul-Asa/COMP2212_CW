import Control.Exception
import NotSqlTokens
import System.Environment
import System.IO

main :: IO ()
main = catch main' noParse

main' = do
  (fileName : _) <- getArgs
  sourceText <- readFile fileName
  putStrLn ("Parsing : " ++ sourceText)
  let parsedProg = parseCalc (alexScanTokens sourceText)
  putStrLn ("Parsed as " ++ (show parsedProg))

noParse :: ErrorCall -> IO ()
noParse e = do
  let err = show e
  hPutStr stderr err
  return ()