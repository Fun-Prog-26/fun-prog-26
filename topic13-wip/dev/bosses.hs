import Control.Monad.State
import Data.Maybe

data Person = Person {name:: String , boss:: Maybe Person} deriving Show

mairead = Person {name="Mairead", boss = Just alan}
alan = Person {name = "Alan", boss = Just peter}
peter = Person {name="Peter", boss = Just veronica}
veronica = Person{name = "Veronica", boss = Nothing}




getBoss:: Person ->  Maybe Person
getBoss worker = do  myboss <- boss worker
                     bigboss <-  boss myboss
                     biggestboss <-  boss bigboss
                     noone <- boss biggestboss
                     return noone;


data Student = Student { sname:: String , courseLeader:: Maybe Lecturer} deriving Show

student1 = Student {sname = "Love Computing", courseLeader = Just rob}
student2 = Student {sname = "not sure", courseLeader = Nothing}
student3 = Student {sname = "Love Forensics", courseLeader = Just john}

data Lecturer = Lecturer {lname :: String , roomNumber :: Maybe String} deriving Show
rob = Lecturer {lname = "Rob", roomNumber = Just "311"}
john = Lecturer { lname = "John", roomNumber = Nothing}

getRoom :: Student -> Maybe String
getRoom student = do 
                   cLeader <-  courseLeader student
                   room  <- roomNumber cLeader
                   return room

getCourseLeader :: Student -> Maybe Lecturer
getCourseLeader student = do 
                          cLeader <- courseLeader  student
                          return cLeader
                         
f = 
    boss veronica >>= (\wboss -> return (wboss))
