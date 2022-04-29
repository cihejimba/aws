require 'sinatra/base'
require 'logger'
require 'aws-record'

class TextsTable
  include Aws::Record
  set_table_name ENV['DYNAMODB_TABLE_NAME']
  string_attr :id, hash_key: true
  string_attr :text
  string_attr :expired_at
end


class WorkerSample < Sinatra::Base
    set :logging, true

    set :public_folder, 'public'

    @@logger = Logger.new('/tmp/sample-app.log')

    get "/" do
        redirect '/index.html'
    end

    post '/' do
        msg_id = request.env["HTTP_X_AWS_SQSD_MSGID"]
        data = request.body.read

        item_id = request.env["HTTP_X_AWS_SQSD_ATTR_ID"]
        
        item = TextsTable.find(id: item_id)
        
        @@logger.info "Received message: #{data} msgid=#{msg_id} item=#{item.text} item_id=#{item_id}"
    end

    post '/scheduled' do
        task_name = request.env["HTTP_X_AWS_SQSD_TASKNAME"]
        scheduling_time = request.env["HTTP_X_AWS_SQSD_SCHEDULED_AT"]
        @@logger.info "Received task: #{task_name} scheduled at #{scheduling_time}"
    end
end
