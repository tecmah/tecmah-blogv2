require 'google/cloud/translate'

class GoogleTranslate
    def self.translate(title)
        # Google Cloud Translate APIを使って日本語のタイトルを英語に翻訳
        translate = Google::Cloud::Translate.new(project: ENV["GOOGLE_CLOUD_PROJECT_ID"])
        translation = translate.translate text, to: "en"
    end
end