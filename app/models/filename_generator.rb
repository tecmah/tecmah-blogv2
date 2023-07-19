require 'date'

class FilenameGenerator
    # ファイル名の生成（日付とタイトルから）
    def self.generate_filename(title)
        slug = title.downcase.gsub(" ", "-")
        filename = "#{slug}.md"
    end
end