import Text.Pandoc
import System.IO

-- Your Pandoc document
myPandocDocument :: Pandoc
myPandocDocument = Pandoc nullMeta [Plain [Str "Hello", Space, Str "world!"]]

-- Function to write Pandoc document to a Markdown file
writePandocToMarkdown :: FilePath -> Pandoc -> IO ()
writePandocToMarkdown filePath pandocDoc = writeFile filePath $ writeMarkdown def pandocDoc

main :: IO ()
main = do
    let mdFilePath = "output.md"
    writePandocToMarkdown mdFilePath myPandocDocument
    putStrLn $ "Pandoc document has been written to " ++ mdFilePath
