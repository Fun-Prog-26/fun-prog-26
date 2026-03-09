safetail' :: [a] ->  Maybe  [a]
safetail' [] =    Nothing
safetail' xs =    Just (tail xs )

safetail'' :: Eq a =>  [a]  -> Either String  [a]
safetail''  xs = if xs==[]then Left  "Cannot have tail of empty list"
                              else Right (tail xs)