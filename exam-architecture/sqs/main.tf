resource "aws_sqs_queue" "standard-sqs-queue" {
    name = "standard-sqs-queue"
    delay_seconds             = 90
    max_message_size          = 2048
    message_retention_seconds = 86400
    receive_wait_time_seconds = 10
    
    fifo_queue                = false
    
    policy = <<POLICY
    
    {
      "Version": "2008-10-17",
      "Id": "__default_policy_ID",
      "Statement": [
        {
          "Sid": "__owner_statement",
          "Effect": "Allow",
          "Principal": {
            "AWS": "537851388570"
          },
          "Action": [
            "SQS:*"
          ],
          "Resource": "arn:aws:sqs:us-east-1:537851388570:"
        }
      ]
    }
    
    POLICY
    
    tags = {
        Environment = "dev"
    }
}