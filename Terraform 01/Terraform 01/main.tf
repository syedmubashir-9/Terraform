provider "aws" {

    region = var.region
  
}


resource "random_string" "random" {

    length = 6
    special = false
    upper = false
  
}


resource "aws_s3_bucket" "s3_buckets_Whizlabs" {

    bucket = "whizlabs-${random_string.random.result}"
    force_destroy = true
}



 
resource "aws_sns_topic" "topic" {
  name = "whiz-s3-event-notification"
  policy = <<POLICY
{
    "Version":"2012-10-17",
    "Statement":[
        {
        "Effect": "Allow",
        "Principal": { "Service": "s3.amazonaws.com" },
        "Action": "SNS:Publish",
        "Resource": "arn:aws:sns:*:*:whiz-s3-event-notification",
        "Condition":{
            "ArnLike":{"aws:SourceArn":"${aws_s3_bucket.s3_buckets_Whizlabs.arn}"}
            }
        }
    ]
}
POLICY
}



resource "aws_sns_topic_subscription" "Whizlabs-subscription" {

    topic_arn = aws_sns_topic.topic.arn
    protocol = "email"
    endpoint = var.endpoint
  
}



resource "aws_s3_bucket_notification" "bucket_notification" {

    bucket = aws_s3_bucket.s3_buckets_Whizlabs.id
    topic {
        topic_arn = aws_sns_topic.topic.arn
        events = ["s3:ObjectCreated:*"]
      
    }
  
}


