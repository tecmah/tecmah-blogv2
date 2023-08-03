class MetadataHandler
    # ファイルのメタデータの生成
    def self.generate(title)
        puts "title before generate: #{title}"  # <--- これを追加
        date = DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z")
        metadata = {
        "layout" => "post",
        "title" => title,
        "date" => date,
        }
        puts "title in metadata: #{metadata["title"]}"  # <--- これを追加
        metadata
    end
    
end
