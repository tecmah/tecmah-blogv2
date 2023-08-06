require 'logger'
require_relative 'title_handler'
require_relative 'openai_client'
require_relative 'filename_generator'
require_relative 'metadata_handler'
require_relative 'markdown_file_generator'
require_relative 'title_updater'


log = Logger.new(STDOUT)

title = TitleHandler.get_title

# コマンドラインからPath入力を受け取る
prompt_path = ARGV[0]

log.debug(prompt_path + "を読み込みます") 

# promptの読み込み
prompt = OpenaiClient.generate_prompt(prompt_path)

# プロンプト内の '#{title}' を title 引数の値で置換
prompt = prompt.gsub('#{title}', title)

log.debug(prompt)

# contextの生成
content = OpenaiClient.generate_content(title, prompt)

log.debug(content)

# 認証まわりを整えるため一旦、コメントアウト
# 翻訳
# translated_title = GoogleTranslate.translate(title) 

#　ファイル名の生成
# filename = FilenameGenerator.generate_filename(translated_title)
filename = FilenameGenerator.generate_filename(title)

log.debug(title)
# メタデータの生成
metadata = MetadataHandler.generate(title)

log.debug(metadata[:title])

puts "metadata before MarkdownFileGenerator.generate: #{metadata}"

# ファイルの生成
MarkdownFileGenerator.generate(metadata, content, filename)

TitleUpdater.update(title)

log.debug(filename + "を生成しました")
