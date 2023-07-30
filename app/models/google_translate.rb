require 'optparse'
require 'google/cloud/translate/v2'

def translate
  project_id = ENV['GOOGLE_CLOUD_PROJECT_ID']
  key = ENV['GOOGLE_TRANSLATE_KEY']
  translate = Google::Cloud::Translate::V2.new
end
  
    translation = translate.translate "Hello world!", to: "la"
    puts translation