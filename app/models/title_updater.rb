class TitleUpdater
    # タイトルを generated-finished.md に追加
    def self.update(title)
        generated_finished_path = File.join("app/title", "generated-finished.md")
        File.open(generated_finished_path, 'a') do |file|
        file.puts title
        end
    end
end
