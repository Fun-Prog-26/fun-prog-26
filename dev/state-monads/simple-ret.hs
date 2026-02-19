-- a concrete and simple example of using the State monad


import Control.Monad.State

-- non monadic version of a very simple state example
-- the State is an integer.
-- the value will always be the negative of the state
--type GameValue = Int
type GameState = (Int , Char)


initial state = 1 :: Int
final value = 'X' :: Char
final state = 1 :: Int
result = ('X', 1) :: (Char, Int)


main = print $ evalState initial state