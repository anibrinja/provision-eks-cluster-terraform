terraform {
  backend "s3" {
    bucket         = "s3-bucket-ab"           # Replace with your S3 bucket name
    key            = "terraform.tfstate"      # Replace with your state file name
    region         = "eu-central-1"           # Replace with your AWS region
    encrypt        = true                     # Enable or disable state file encryption
  }
}
