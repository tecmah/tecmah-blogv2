require 'rspec'
require_relative '../../app/models/openai_client'

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
      allow(File).to receive(:open).with(prompt_path).and_return('Your prompt content')
    end

    it 'returns expected content' do
      expect(OpenaiClient.generate_prompt(prompt_path)).to eq('Your expected content')
    end
  end
end
