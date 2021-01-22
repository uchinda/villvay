terraform {
  backend "s3" {
    bucket = "villvat--state--us-west-2"
    key    = "villvay/terraform.tfstate"
    region = "us-west-2"
  }
}