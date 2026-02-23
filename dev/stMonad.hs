data Tree a
  = Leaf a
  | Branch (Tree a) (Tree a)


mapTree :: (a -> b) -> Tree a -> Tree b
mapTree f (Leaf a) = Leaf (f a)
mapTree f (Branch lhs rhs) =
    Branch (mapTree f lhs) (mapTree f rhs)

mapTreeState :: (a -> state -> (state, b)) ->
                Tree a -> state -> (state, Tree b)
mapTreeState f (Leaf a) state =
    let (state', b) = f a state
    in  (state', Leaf b)
mapTreeState f (Branch lhs rhs) state =
    let (state' , lhs') = mapTreeState f lhs state
        (state'', rhs') = mapTreeState f rhs state'
    in  (state'', Branch lhs' rhs')

type State st a = st -> (st, a)
returnState :: a -> State st a
returnState a = \st -> (st, a)

bindState :: State st a -> (a -> State st b) ->
             State st b
bindState m k = \st ->
    let (st', a) = m st
        m'       = k a
    in  m' st'

mapTreeStateM :: (a -> State st b) -> Tree a -> State st (Tree b)

mapTreeStateM f (Leaf a) =
  f a `bindState` \b ->
  returnState (Leaf b)
mapTreeStateM f (Branch lhs rhs) =
  mapTreeStateM f lhs `bindState` \lhs' ->
  mapTreeStateM f rhs `bindState` \rhs' ->
  returnState (Branch lhs' rhs')

data Result a = Succeed a | Fail
-- class Applicative m => Monad m where
-- return :: a -> m a
-- (>>=) :: m a -> (a -> m b) -> m c

-- instance Monad Result where
--  --     return         :: a -> Result a
--       return x        =  Succeed x
--  --     (>>=)		     :: Result a -> (a -> Result b) -> Result b      
--       Fail  >>= _     =  Fail
--       (Succeed x) >>= f   =  f x

--       newtype Mlist a = Mlist {mlist::[a]}

instance Monad Mlist where
  return x  = Mlist [x]
  m >>= f   = if nil (mlist m)
                       then Mlist []
                       else Mlist (take 1 (mlist (f (head (mlist m)))))

nil :: [a] -> Bool
nil [] = True
nil _  = False
