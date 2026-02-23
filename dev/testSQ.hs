{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

import Data.Time (Day, parseTimeM, defaultTimeLocale)
import GHC.Generics (Generic)
-- import Data.Csv (FromNamedRecord, FromField (..))
data QuoteData = QuoteData {
                   day :: Day,
                   volume :: Int,
                   open :: Double,
                   close :: Double,
                   high :: Double,
                   low :: Double
                 }
  deriving (Show)

  -- oneDay :: QuoteData
  -- oneDay  = QuoteData 

  -- tody :: Day
  tody = Day $  2020 09 30