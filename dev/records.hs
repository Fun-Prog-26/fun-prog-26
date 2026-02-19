data Student where
  Student :: {firstName :: String,
                lastName :: String,
                age :: Int,
                course :: String,
                email :: String}
               -> Student
  deriving (Show)   

student1 = Student {firstName = "Adam", lastName="Ant", age=21, course="Applied", email="mm"}