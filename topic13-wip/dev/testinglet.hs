bmiTell :: Double -> Double -> String
bmiTell weight height 
   | bmi <= skinny = "You're underweight, you emo, you!"
   | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
   | bmi <= fat    = "You're fat! Lose some weight, fatty!"
   | otherwise     = "You're a whale, congratulations!"
   where bmi = weight / (height ^ 2)
         (skinny,normal,fat) = (18.5, 25.0, 30.0)

mysignum :: Int -> Int
mysignum n = if n < 0 then -1 else
              if n == 0 then 0 else 1

myhead ::[a] -> a
myhead[] = error "No head for empty lists"
myhead(x:_) = x


annualSalaryCalc :: (RealFloat a) => a -> a -> String
annualSalaryCalc hourlyRate weekHoursOfWork
   | hourlyRate * (weekHoursOfWork * 52) <= 40000 = "Poor child, try to get another job"
   | hourlyRate * (weekHoursOfWork * 52) <= 120000 = "Money, Money, Money!"
   | hourlyRate * (weekHoursOfWork * 52) <= 200000 = "Ri¢hie Ri¢h"
   | otherwise = "Hello Elon Musk!"

cylinder :: Double -> Double -> Double
cylinder r h =



