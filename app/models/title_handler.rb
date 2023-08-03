require 'dotenv'

class TitleHandler
    def self.get_title
        # 環境変数のロード
        Dotenv.load

        # タイトルリストから最初のタイトルを取得し、それを削除
        title_list_path = File.join("app/title", "title-list.md")
        title = File.readlines(title_list_path).first.strip
        remaining_titles = File.readlines(title_list_path)[1..-1]
        File.open(title_list_path, 'w') do |file|
        file.puts remaining_titles
        end

        title
    end
end