import Control.Monad.State
type Stack  =  [Int]

pop :: State Stack Int
pop = state $ \(x:xs) -> (x, xs)
push :: Int -> State Stack ()
push a = state $ \xs -> ((), a:xs)


stackManip :: State Stack Int
stackManip = do
    push 3
    a <- pop
    pop

stackStuff :: State Stack ()
stackStuff = do
    a <- pop
    if a == 5
     then push 5
     else do
      push 3
      push 8


type Queue = [Int]
enQueue :: Int -> State Queue ()
enQueue x = state $ \xs -> ((), xs++[x])

deQueue :: State Queue Int
deQueue = state $ \(x:xs) -> (x, xs)

queueManip  :: State Queue Int
queueManip = do
    enQueue 4
    enQueue 5
    deQueue