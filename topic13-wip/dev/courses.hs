
data Student = Student { sname:: String , course:: Maybe Course} deriving Show

student1 = Student {sname = "student1", course = Just applied}
student2 = Student {sname = "potentialstudent1", course = Nothing}
student3 = Student {sname = "student3", course = Just forensics}

data Lecturer = Lecturer {lname :: String , roomNumber :: Maybe String} deriving Show
rob = Lecturer {lname = "Robert", roomNumber = Just "311"}
john = Lecturer { lname = "John", roomNumber = Nothing}


data Course = Course {cname:: String ,leader:: Maybe Lecturer} deriving Show
applied = Course {cname = "Applied Computing", leader = Just rob}
forensics = Course {cname  = "Forensics", leader = Just john}
newCourse = Course {cname = "Brave New Course", leader = Nothing }

getCourseLeader :: Student -> Maybe Lecturer
getCourseLeader student = do 
                            course <- course student
                            lead <- leader course
                            return lead

findWhereCourseLeader :: Student -> Maybe String
findWhereCourseLeader student = do
                                  course <- course student
                                  lead <- leader course
                                  room <- roomNumber lead
                                  return room


getRoom :: Student -> Maybe String
getRoom student = do
     leader <- courseLeader student
     roomNumber leader

getLeader :: Student -> Maybe Lecturer
getLeader student = courseLeader student