# Input S3 bucket of the transcode

// create S3 Bucket to be used as logging target
module "logging_universityofprofessorex_target" {
    source  = "operatehappy/s3-bucket/aws"
    version = "1.2.0"
    name    = "universityofprofessorex-s3-fixtures-logging-target"
    acl     = "log-delivery-write"
    create_readme = false

    lifecycle_rule = [{
      id                                     = "CleanAllOldData"
      enabled                                = true
      abort_incomplete_multipart_upload_days = "7"

      expiration = {
        days                         = "90"
        expired_object_delete_marker = "false"
      }

      noncurrent_version_expiration = {
        days = "90"
      }
    }]
}

module "universityofprofessorex" {
    source  = "operatehappy/s3-bucket/aws"
    version = "1.2.0"
    acl    = "public-read"
    create_readme = false

    name = "universityofprofessorex-fixtures-${var.env_location}"

    tags = merge(
      var.s3_universityofprofessorex_tags,
      {
        "name"                     = "universityofprofessorex-fixtures-${var.env_location}"
        "environment"              = var.environment
        "Role"                     = "universityofprofessorex-fixtures-${var.env_location}"
        "Environment"              = var.environment
        "Owner"                    = "iamprofessorex"
        "DataClassification"       = "Public"
      },
    )
    logging = {
        target_bucket = module.logging_universityofprofessorex_target.id
        target_prefix = "logs"
    }
}


resource "aws_s3_bucket_policy" "universityofprofessorex" {
  bucket = module.universityofprofessorex.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "UNIVERSITYOFPROFESSOREXBUCKETPOLICY2",
  "Statement": [
    {
      "Sid": "S3Allow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${module.universityofprofessorex.arn}/fixtures/*"
    }
  ]
}
POLICY

}



