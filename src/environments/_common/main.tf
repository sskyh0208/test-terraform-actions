module "lambda_example" {
  source = "../../modules/lambda"

  name_prefix        = "${local.common.env}-${var.product}"
  function_name      = local.lambda.example.name
  hadler_file        = local.lambda.example.handler_file
  description        = local.lambda.example.description
  architectures      = local.lambda.example.architectures
  rumtime            = local.lambda.example.runtime
  handler            = local.lambda.example.handler
  enviroment         = local.lambda.example.environment
  ephemeral_storage  = local.lambda.example.ephemeral_storage
  timeout            = local.lambda.example.timeout
  
  s3_bucket_name     = module.s3_main.name
  iam_role           = module.iam_role_example.arn
  layer              = []
  vpc_config         = {}
  dead_letter_config = {}
  
  tags = {
    Name = "${local.common.env}-${var.product}"
    Env = local.common.env
    Product = var.product
  }
}