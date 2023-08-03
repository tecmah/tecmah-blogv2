class MarkdownFileGenerator
    # _draftsディレクトリにMarkdownファイルを生成
    def self.generate(metadata, content)
        # メタデータをYAMLフォーマットに変換
        yaml_front_matter = metadata.map { |k, v| "#{k}: #{v}" }.join("\\n")

        title = metadata["title"]

        # titleがnilでないことを確認
        if title.nil?
          raise ArgumentError, "metadata[:title] cannot be nil"
        end

        File.open(File.join("_drafts", title), "w") do |f|
            f.write("---\\n")
            f.write(yaml_front_matter)
            f.write("\\n---\\n")
            f.write(content)
        end
    end
end