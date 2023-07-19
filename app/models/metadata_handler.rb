class MetadataHandler
    # ファイルのメタデータの生成
    def self.generate(title)
        date = DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z")
        metadata = {
        "layout" => "post",
        "title" => title,
        "date" => date,
        }

        # メタデータをYAMLフォーマットに変換
        yaml_front_matter = metadata.map { |k, v| "#{k}: #{v}" }.join("\\n")
    end
end