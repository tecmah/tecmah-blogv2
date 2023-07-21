require_relative 'title_handler'
require_relative 'openai_client'
require_relative 'google_translate'
require_relative 'filename_generator'
require_relative 'metadata_handler'
require_relative 'markdown_file_generator'
require_relative 'title_updater'

title = TitleHandler.get_title

content = OpenaiClient.generate_prompt(title)

# 認証まわりを整えるため一旦、コメントアウト
# translated_title = GoogleTranslate.translate(title) 

# filename = FilenameGenerator.generate_filename(translated_title)
filename = FilenameGenerator.generate_filename(title)

metadata = MetadataHandler.generate(title)

MarkdownFileGenerator.generate(metadata, content)

TitleUpdater.update(title)