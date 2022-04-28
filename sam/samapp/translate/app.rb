require 'json'
require 'securerandom'
require 'aws-record'

class TextsTable
  include Aws::Record
  set_table_name ENV['TEXTS_TABLE']
  string_attr :id, hash_key: true
  string_attr :text
  string_attr :expired_at
end

def lambda_handler(event:, context:)
  # Sample pure Lambda function

  # Parameters
  # ----------
  # event: Hash, required
  #     API Gateway Lambda Proxy Input Format
  #     Event doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html#api-gateway-simple-proxy-for-lambda-input-format

  # context: object, required
  #     Lambda Context runtime methods and attributes
  #     Context doc: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html

  # Returns
  # ------
  # API Gateway Lambda Proxy Output Format: dict
  #     'statusCode' and 'body' are required
  #     # api-gateway-simple-proxy-for-lambda-output-format
  #     Return doc: https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-lambda-proxy-integrations.html

  text = event['queryStringParameters']['text']
  uuid = SecureRandom.uuid
  expired_at = (Time.now + 60*60*24).to_i

  item = TextsTable.new(id: uuid, text: text, expired_at: expired_at)
  item.save!
  item.to_h
  
  # https://github.com/awsdocs/aws-doc-sdk-examples/blob/main/ruby/example_code/sqs/sqs-ruby-example-send-receive-messages.rb

  begin
    queue_url = ENV['SQS_QUEUE_URL']

    # Create a message with three custom attributes: Title, Author, and WeeksOn.
    send_message_result = sqs.send_message({
                                             queue_url: queue_url,
                                             message_body: "",
                                             message_attributes: {
                                               "id" => {
                                                 string_value: uuid,
                                                 data_type: "String"
                                               }
                                             }
                                           })
  rescue Aws::SQS::Errors::NonExistentQueue
    puts "A queue url '#{queue_url}' does not exist."
    exit(false)
  end

  puts send_message_result.message_id
  
  {
    statusCode: 200,
    body: {
      text: text,
      uuid: uuid,
      expired_at: expired_at
    }.to_json
  }
  
end

