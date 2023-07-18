terraform {
  backend "s3" {
    bucket = "tellambda-example"
    key    = "prod/datasource/terraformn.tfstate"
    region = "ap-northeast-1"
  }
}