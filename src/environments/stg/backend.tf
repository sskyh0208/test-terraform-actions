terraform {
  backend "s3" {
    bucket = "tellambda-example"
    key    = "stg/datasource/terraformn.tfstate"
    region = "ap-northeast-1"
  }
}