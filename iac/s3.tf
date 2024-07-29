resource "aws_s3_bucket" "my-app-images" {
  bucket = "devraghavm-my-super-app-images" // Use unique name for your bucket
}

resource "aws_s3_object" "images_folder" {
  bucket = aws_s3_bucket.my-app-images.bucket
  key    = "images/"
}

resource "aws_s3_object" "thumbnails_folder" {
  bucket = aws_s3_bucket.my-app-images.bucket
  key    = "thumbnails/"
}

resource "null_resource" "wait_for_lambda_trigger" {
  depends_on = [aws_lambda_permission.apigw_lambda]
  provisioner "local-exec" {
    command = "sleep 3m"
  }
}

resource "aws_s3_bucket_notification" "images_put_notification" {
  bucket     = aws_s3_bucket.my-app-images.id
  depends_on = [null_resource.wait_for_lambda_trigger]
  topic {
    topic_arn     = aws_sns_topic.topic.arn
    filter_prefix = "images/"
    events        = ["s3:ObjectCreated:*"]
  }
}
