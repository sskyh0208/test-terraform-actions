locals {
    key      = "${var.function_name}.zip"
    key_hash = "${var.function_name}.zip.base64sha256"
    base_dir = "../../lambda/${var.function_name}"
}

#------------------------
# data
#------------------------
data "aws_s3_object" "lambda_function_archive" {
    depends_on = [ null_resource.deploy_lambda_function ]
    bucket     = var.s3_bucket_name
    key        = local.key
}

data "aws_s3_object" "lambda_function_archive_hash" {
  depends_on = [ null_resource.deploy_lambda_function ]
  bucket     = var.s3_bucket_name
  key        = "${local.key_hash}.txt"
}

#------------------------
# deploy
#------------------------
resource "null_resource" "deploy_lambda_function" {
    # Lambda関数コードが変更された場合に実行される
    triggers = {
        "code_diff" = filebase64("${local.base_dir}/${var.handler_file}")
    }

    # ディレクトリ階層を無視(-j)して関数コードをzipアーカイブする
    provisioner "local-exec" {
        command = "zip -j ${local.base_dir}/${local.key} ${local.base_dir}/*"
    }

    # デプロイ用のS3バケットにzipアーカイブした関数コードをアップロードする
    provisioner "local-exec" {
        command = "aws s3 cp ${local.base_dir}/${local.key} s3://${var.s3_bucket_name}/${local.key}"
    }

    # zipアーカイブした関数コードのhashを取得してファイルに書き込む
    provisioner "local-exec" {
        command = "openssl dgst -sha256 -binary ${local.base_dir}/${local.key} | openssl enc -base64 | tr -d \"\n\" > ${local.base_dir}/${local.key_hash}"
    }

    # hash値を書き込んだファイルをデプロイ用のS3バケットにアップロードする
    provisioner "local-exec" {
        command = "aws s3 cp ${local.base_dir}/${local.key_hash} s3://${var.s3_lambda_deploy}/${local.key_hash}.txt --content-type \"text/plain\""
    }
}

#----------
# Lambda function
#----------

resource "aws_lambda_function" "function" {
  function_name      = "${var.name_prefix}_${var.function_name}"
  description        = var.description
  role               = var.iam_role_arn
  architectures      = var.archtectures
  runtime            = var.runtime
  handler            = var.handler
  layer              = var.layer
  environment        = var.environment
  s3_bucket          = var.s3_bucket_name
  s3_key             = data.aws_s3_object.lambda_function_archive.key
  source_code_hash   = data.aws_s3_object.lambda_function_archive_hash.body
  memory_size        = var.memory_size
  timeout            = var.timeout
  ephemeral_storage  = var.ephemeral_storage
  vpc_config         = var.vpc_config
  dead_letter_config = var.dead_letter_config
  tags               = var.tags
}