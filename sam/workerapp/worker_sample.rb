require 'sinatra/base'
require 'logger'
require 'aws-record'
require 'aws-sdk-translate'

class TextsTable
  include Aws::Record
  set_table_name ENV['DYNAMODB_TABLE_NAME']
  string_attr :id, hash_key: true
  string_attr :text
  string_attr :translation
  string_attr :expired_at
end


class WorkerSample < Sinatra::Base
  set :logging, true

  set :public_folder, 'public'

  @@logger = Logger.new('/tmp/sample-app.log')

  def initialize
    super
    @translate_client = Aws::Translate::Client.new
  end
  
  
  get "/" do
    redirect '/index.html'
  end

  post '/' do
    msg_id = request.env["HTTP_X_AWS_SQSD_MSGID"]
    item_id = request.env["HTTP_X_AWS_SQSD_ATTR_ID"]
    data = request.body.read
    
    item = TextsTable.find(id: item_id)

    if not item.nil?
      #client = Aws::Translate::Client.new
      src_text = item.text
      resp = @translate_client.translate_text({
                                                text: src_text,
                                                source_language_code: "auto",
                                                target_language_code: "en"
                                              })
      trans_txt = resp.translated_text
      item.translation = trans_txt
      item.save!
    end
    
    @@logger.info "Received message: #{data} msgid=#{msg_id} item_id=#{item_id} src_text=#{src_text} trans_txt=#{trans_txt}"
  end

  post '/scheduled' do
    task_name = request.env["HTTP_X_AWS_SQSD_TASKNAME"]
    scheduling_time = request.env["HTTP_X_AWS_SQSD_SCHEDULED_AT"]
    @@logger.info "Received task: #{task_name} scheduled at #{scheduling_time}"
  end
end
