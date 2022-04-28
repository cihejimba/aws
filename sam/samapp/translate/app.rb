require 'json'
require 'securerandom'
require 'aws-record'
require 'aws-sdk-sqs'

class TextsTable
  include Aws::Record
  set_table_name ENV['TEXTS_TABLE']
  string_attr :id, hash_key: true
  string_attr :text
  string_attr :expired_at
end

def lambda_handler(event:, context:)
  text = event['queryStringParameters']['text']
  uuid = SecureRandom.uuid
  expired_at = (Time.now + 60*60*24).to_i

  item = TextsTable.new(id: uuid, text: text, expired_at: expired_at)
  item.save!
  item.to_h
  
  sqs_msg_id = ""
  begin
    sqs = Aws::SQS::Client.new
    queue_url = ENV['SQS_QUEUE_URL']
    send_message_result = sqs.send_message({
                                             queue_url: queue_url,
                                             message_body: Time.now.to_s,
                                             message_attributes: {
                                               "id" => {
                                                 string_value: uuid,
                                                 data_type: "String"
                                               }
                                             }
                                           })
    sqs_msg_id = send_message_result.message_id
  rescue => e
    sqs_msg_id = e.message
  end

  {
    statusCode: 200,
    body: {
      text: text,
      uuid: uuid,
      expired_at: expired_at,
      sqs_msg_id: sqs_msg_id
    }.to_json
  }
  
end

