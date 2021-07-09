variable "region" {
}

variable "environment" {
}

variable "env_location" {
}

variable "s3_universityofprofessorex_tags" {
  type = map(string)
  default = {
    "Class"         = "Other"
    "ArchPath"      = "UniversityOfProfessorEX.S3"
  }
}

