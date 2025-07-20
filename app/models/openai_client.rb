require 'openai'
require 'json'
require 'logger'

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
        log = Logger.new(STDOUT)
        log.debug("generate_content called with title: #{title}, prompt: #{prompt}")

        # プロンプト内の '#{title}' を title 引数の値で置換
        prompt = prompt.gsub('#{title}', title)

        client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
        response = client.chat(
          parameters: {
            model: "gpt-4o",
            messages: [{ role: "user", content: prompt }],
            temperature: 0.7,
          }
        )

        log.debug("OpenAI API response: #{response}")

        if response.is_a?(Hash) && response["error"]
          error_message = response.dig("error", "message")
          log.error("OpenAI API error: #{error_message}")
          
          if response.dig("error", "code") == "insufficient_quota"
            log.error("API使用量制限に達しました。請求設定を確認してください。")
          end
          
          return nil
        end

        response.dig("choices", 0, "message", "content")
    end

    def self.test_connection
        log = Logger.new(STDOUT)
        client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
        
        begin
            response = client.chat(
                parameters: {
                    model: "gpt-3.5-turbo",
                    messages: [{ role: "user", content: "Hello" }],
                    max_tokens: 5
                }
            )
            
            log.debug("Test API response: #{response}")
            
            if response.is_a?(Hash) && response["error"]
                log.error("API接続エラー: #{response["error"]["message"]}")
                return false
            end
            
            return true
        rescue => e
            log.error("API接続テスト中にエラーが発生: #{e.message}")
            return false
        end
    end
end