variable "name_prefix" {
  type = string
}
variable "function_name" {
  type = string
}
variable "handler_file" {
  type = string
}
variable "s3_bucket_name" {
  type = string
}
variable "description" {
  type = string
}
variable "iam_role_arn" {
  type = string
}
variable "architectures" {
  type    = list(string)
  default = [ "x86_64" ]
}
variable "runtime" {
  type = string
}
variable "handler" {
  type = string
}
variable "environment" {
  type    = map(string)
  default = {}
}
variable ""layer"" {
  type    = list(string)
  default = {}
}
variable "memory_size" {
  type    = number
  default = 128
}
variable "ephemeral_storage" {
  type    = map(number)
  default = {size = 512}
}
variable "timeout" {
  type    = number
  default = 3
}
variable "vpc_config" {
  type    = map(string)
  default = {}
}
variable "dead_letter_config" {
  type    = map(string)
  default = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}