class MarkdownFileGenerator
    # _draftsディレクトリにMarkdownファイルを生成
    def self.generate(metadata, content, filename)
        # メタデータをYAMLフォーマットに変換
        yaml_front_matter = metadata.map { |k, v| "#{k}: #{v}" }.join("\n")

        title = metadata["title"]

        # titleがnilでないことを確認
        if title.nil?
          raise ArgumentError, "metadata[:title] cannot be nil"
        end

        File.open(File.join("_drafts", filename), "w") do |f|
            f.write(<<~TEXT)
            ---
            #{yaml_front_matter}
            ---
            #{content}
          TEXT
        end
    end
end