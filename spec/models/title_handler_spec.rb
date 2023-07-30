require 'rspec'
require_relative '../../app/models/title_handler'

describe TitleHandler do
  describe '.get_title' do
    let(:title_list_path) { 'app/title/dummy_title_list.md' }
    let(:titles) { ["Title 1", "Title 2", "Title 3"] }

    before do
      # ダミーのタイトルリストを作成
      File.open(title_list_path, 'w') do |file|
        file.puts titles
      end

      # TitleHandlerがダミーのタイトルリストを使用するように設定
      allow(File).to receive(:join).and_return(title_list_path)
    end

    after do
      # テスト終了後にダミーのタイトルリストを削除
      File.delete(title_list_path)
    end

    it 'returns the first title and removes it from the list' do
      expect(TitleHandler.get_title).to eq(titles.first)
      expect(File.readlines(title_list_path).map(&:strip)).to eq(titles[1..-1])
    end
  end
end
