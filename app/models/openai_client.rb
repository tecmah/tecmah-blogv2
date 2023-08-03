require 'openai'
require 'json'

class OpenaiClient

    def self.generate_prompt(prompt_path)
        # ファイルの読み込み
        file = File.open(prompt_path)
        # ファイルの中身を読み込み
        body = file.read
        # ファイルを閉じる
        file.close
        # 読み込んだファイルの中身を返す
        body
    end

    def self.generate_content(title, prompt)
        # OpenAIクライアントの初期化
        client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

        # プロンプト内の '#{title}' を title 引数の値で置換
        prompt = prompt.gsub('#{title}', title)
    
        # OpenAI APIを使って文章を生成
        response = client.chat(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: [
              { role: "user", content: prompt }
            ],
            temperature: 0.7,
          }
        )
    
        # OpenAIからのレスポンスをcontentに格納
        content = response.dig("choices", 0, "message", "content")
      end
    end