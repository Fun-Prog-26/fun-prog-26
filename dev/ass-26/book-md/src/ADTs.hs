module ADTs where
    
    
data Catalogue = Catalogue [Book]
  deriving Show

data Book = Book
  { isbn      :: String
  , title     :: String
  , subtitle  :: Maybe String
  , authors   :: [Author]
  , year      :: Int
  } deriving Show

data Author = Author
  { authorId   :: String
  , authorName :: String
  } deriving Show

