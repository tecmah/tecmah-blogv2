require 'rspec'
require_relative '../../app/models/openai_client'
require 'stringio'

describe OpenaiClient do
  describe '.generate_prompt' do
    let(:prompt_path) { 'path_to_your_prompt.txt' }

    before do
      # スタブメソッドを設定してOpenAI APIの呼び出しをシミュレート
      allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return({
        'choices' => [
          {
            'message' => {
              'content' => 'Your expected content'
            }
          }
        ]
      })

      # スタブメソッドを設定してFile.openの呼び出しをシミュレート
      allow(File).to receive(:open).with(prompt_path).and_return(StringIO.new('Your prompt content'))
    end

    it 'returns expected content' do
      expect(OpenaiClient.generate_prompt(prompt_path)).to eq('Your prompt content')
    end
  end

  describe '.test_api_connection' do
    let(:test_response) { 
      {
        'choices' => [
          {
            'message' => {
              'content' => 'Test response'
            }
          }
        ]
      }
    }

    context '正常な接続の場合' do
      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return(test_response)
      end

      it 'APIに正常に接続できること' do
        client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
        response = client.chat(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: "Hello" }],
            max_tokens: 5
          }
        )
        
        expect(response).to be_a(Hash)
        expect(response["error"]).to be_nil
        expect(response).to eq(test_response)
      end
    end

    context 'エラーが発生する場合' do
      let(:error_response) {
        {
          "error" => {
            "message" => "Test error message",
            "type" => "test_error",
            "code" => "insufficient_quota"
          }
        }
      }

      before do
        allow_any_instance_of(OpenAI::Client).to receive(:chat).and_return(error_response)
      end

      it 'エラーレスポンスを適切に処理すること' do
        client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
        response = client.chat(
          parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: "Hello" }],
            max_tokens: 5
          }
        )

        expect(response["error"]).not_to be_nil
        expect(response["error"]["code"]).to eq("insufficient_quota")
      end
    end
  end
end
