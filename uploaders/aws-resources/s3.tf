# Input S3 bucket of the transcode
resource "aws_s3_bucket" "universityofprofessorex" {
  bucket = "universityofprofessorex-ml-${var.env_location}"
  acl    = "public-read"

  tags = merge(
    var.s3_universityofprofessorex_tags,
    {
      "name"                     = "universityofprofessorex-ml-${var.env_location}"
      "environment"              = var.environment
      "Role"                     = "universityofprofessorex-ml-${var.env_location}"
      "Environment"              = var.environment
      "Owner"                    = "iamprofessorex"
      "DataClassification"       = "Public"
    },
  )
}

resource "aws_s3_bucket_policy" "universityofprofessorex" {
  bucket = aws_s3_bucket.universityofprofessorex.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "UNIVERSITYOFPROFESSOREXBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "S3Allow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.universityofprofessorex.arn}/ml/*"
    }
  ]
}
POLICY

}



