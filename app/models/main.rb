require "openai"
require "Dotenv"

Dotenv.load

prompt = <<'EOS'
あなたはエンジニアです。
マークダウンでブログを丁寧に読者に分かるように
たまにギャグをもりこんで書いてください。
タイトル:OpenAI APIをRubyで実装した
EOS
client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt}],
        temperature: 0.7,
    })
puts response
puts response.dig("choices", 0, "message", "content")
