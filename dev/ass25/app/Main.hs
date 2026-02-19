import Lecturer
import Data.Csv (decodeByName, Header)
import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V (Vector, toList)


main :: IO ()
main = do
  result <- readLecturers "data/clean_file.csv"
  case result of
    Left err  -> putStrLn $ "Error: " ++ err
    Right lecturers -> do  
      mapM_ print lecturers
      print $ length lecturers
      print $ validateId $ lecturerID $ head lecturers
  


  -- validations :: [Lecturer] -> [String]
  -- validations lecturers = checkId lecturers
     
  --   -- valid1 -- ++ valid2 ++ valid3 ++ valid4 ++ valid5
  
checkId :: [Lecturer] -> [String]
checkId lecturers =
      let invalidIds = filter (\lecturer -> length (lecturerID lecturer) >= 6 ) lecturers
      in map (\lecturer -> "Invalid ID: " ++ show (id lecturer)) invalidIds

  

readLecturers :: FilePath -> IO (Either String [Lecturer])
readLecturers filePath = do
  csvData <- BL.readFile filePath
  case decodeByName csvData of
    Left err -> return $ Left err
    Right (_, result) -> return $ Right (V.toList result)