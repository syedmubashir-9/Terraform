output "s3-bucket-name" {
    value = aws_s3_bucket.s3_buckets_Whizlabs.id
  
}

output "SNStopicARN" {

    value = aws_sns_topic.topic.arn
  
}