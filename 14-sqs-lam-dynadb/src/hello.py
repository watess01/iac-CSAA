import boto3

def handler(event, context):

    response = "Message Not written to DynamoDB table"
    # read the message from the SQS queue
    for record in event['Records']:
        message = record['body']
        print(f"Received message: {message}")
        # write message to the DynamoDB table
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table('HelloKey')
        table.put_item(Item={'message': message})
        response = "Message written to DynamoDB table"


    print(response)
    return response