# markdown_modifier.rb
# ruby markdown_modifier.rb /path/to/your/markdown/file.md
# This script will add a new line after every period in the markdown file.

def modify_markdown(file_path)
    content = File.read(file_path)
  
    # 「。」の後に改行がない場合、2つの改行を追加
    content.gsub!(/。(?![\n])/m, "。\n\n")
  
    # 「。」の後に1つの改行がある場合、もう1つの改行を追加
    content.gsub!(/。\n(?!\n)/m, "。\n\n")
  
    File.write(file_path, content)
    puts "File modified successfully!"
  end
  
  if ARGV.length != 1
    puts "Usage: ruby markdown_modifier.rb <path_to_markdown_file>"
    exit
  end
  
  file_path = ARGV[0]
  modify_markdown(file_path)
  