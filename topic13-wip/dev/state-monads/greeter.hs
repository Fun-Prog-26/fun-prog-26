import Control.Monad.State
import Data.Monoid
import Control.Monad.Writer

-- data Reader r a = Reader {  runReader :: r -> a }
greeter :: State String String
greeter = do
    name <- get
    put "Some State"
    return ("hello, " ++ name ++ "!")


-- newtype Writer w a = Writer { runWriter :: (a, w) }
-- instance (Monoid w) => Monad (Writer w) where  
--     return x = Writer (x, mempty)  
    -- (Writer (x,v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')  
    
half :: Int -> Writer String Int
half x = do
        tell ("I just halved " ++ show x ++ "!")
        return (x `div` 2)