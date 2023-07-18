locals {
  common = {
    env = "dev"
  }
  lambda = {
    example = {
      name        = "example"
      source_file = "lambda_function.py"
      description = "this is example."
      architectures = [ "x86_64" ]
      runtime = "python3.10"
      handler = "lambda_handler"
      environment = {}
      memory_size = 128
      ephemeral_storage = { size = 512 }
      time = 10
    }
  }
}