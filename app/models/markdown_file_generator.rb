class MarkdownFileGenerator
    # _draftsディレクトリにMarkdownファイルを生成
    def self.generate(metadata, content)
        File.open(File.join("_drafts", filename), "w") do |f|
            f.write("---\\n")
            f.write(yaml_front_matter)
            f.write("\\n---\\n")
            f.write(content)
        end
    end
end