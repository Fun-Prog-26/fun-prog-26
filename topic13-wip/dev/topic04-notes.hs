mySignum :: Int ->  Int
mySignum n = if n < 0 then -1 else
             if n == 0 then 0 else 
             1

myAbs :: Int -> Int
myAbs n = if n >= 0 then n else -n 


annualSalaryCalc' :: (RealFloat a) => a -> a -> String
annualSalaryCalc' hourlyRate weekHoursOfWork
     | annualSalary <= smallSalary = "Poor child, try to get another job"
     | annualSalary <= mediumSalary = "Money, Money, Money!"
     | annualSalary <= highSalary = "Ri￠hie Ri￠h"
     | otherwise = "Hello Elon Musk!"
      where
         annualSalary = hourlyRate 
         (smallSalary, mediumSalary, highSalary) = (40000, 120000, 200000)

test :: RealFloat a => a-> a-> String
test x y 
        | x <y =  "Hello"
        | otherwise = "Goodbye"        
annualSalaryCalc ::  Int -> Int -> String
annualSalaryCalc hourlyRate weekHoursOfWork
   | hourlyRate * (weekHoursOfWork * 52) <= 40000 = "Poor child, try to get another job"
   | hourlyRate * (weekHoursOfWork * 52) <= 120000 = "Money, Money, Money!"
   | hourlyRate * (weekHoursOfWork * 52) <= 200000 = "Ri¢hie Ri¢h"
   | otherwise = "Hello Elon Musk!"
     where
         annualSalary = hourlyRate * (weekHoursOfWork * 52)
         (smallSalary, mediumSalary, highSalary) = (40000, 120000, 200000)
