toPart :: [Char] -> [Char]
toPart recipient = "Dear " ++ recipient ++ ","

bodyPart :: [Char] -> [Char]
bodyPart bookTitle = "Thanks for buying " ++ bookTitle ++ "!"

fromPart :: [Char] -> [Char]
fromPart author = "Best,\n" ++ author

createEmail :: [Char] -> [Char] -> [Char] -> [Char]
createEmail recipient bookTitle author =
  toPart recipient
    ++ "\n\n"
    ++ bodyPart bookTitle
    ++ "\n\n"
    ++ fromPart author

main :: IO ()
main = do
  print "Who is the email for?"
  recipient <- getLine
  print "What is the Title?"
  title <- getLine
  print "Who is the Author?"
  author <- getLine
  print (createEmail recipient title author)
