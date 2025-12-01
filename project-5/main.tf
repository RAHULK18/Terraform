

module "dev-infra" {
    source = "./infra-app"
    env = "dev"
    instance_count = 1
    instance_type = "t2.micro"
    ami_id = "ami-0ecb62995f68bb549"
    bucket_name = "rk-project"
    hash_key = "EmpID"

}

module "stg-infra" {
    source = "./infra-app"
    env = "dev"
    instance_count = 1
    instance_type = "t2.small"
    ami_id = "ami-0ecb62995f68bb549"
    bucket_name = "rk-project"
    hash_key = "EmpID"

}

module "prd-infra" {
    source = "./infra-app"
    env = "dev"
    instance_count = 1
    instance_type = "t2.medium"
    ami_id = "ami-0ecb62995f68bb549"
    bucket_name = "rk-project"
    hash_key = "EmpID"

}