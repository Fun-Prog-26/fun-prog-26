{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Catalogue where

import Data.Text (Text)
import Data.List.NonEmpty (NonEmpty)
import GHC.Generics (Generic)

newtype ISBN = ISBN Text
  deriving (Show, Eq, Ord, Generic)

newtype AuthorId = AuthorId Text
  deriving (Show, Eq, Ord, Generic)

data Author = Author
  { authorId   :: AuthorId
  , authorName :: Text
  } deriving (Show, Eq, Generic)

data Book = Book
  { bookIsbn     :: ISBN
  , bookTitle    :: Text
  , bookSubtitle :: Maybe Text
  , bookAuthors  :: NonEmpty Author
  , bookYear     :: Int
  } deriving (Show, Eq, Generic)

newtype Catalogue = Catalogue
  { catalogueBooks :: [Book]
  } deriving (Show, Eq, Generic)
