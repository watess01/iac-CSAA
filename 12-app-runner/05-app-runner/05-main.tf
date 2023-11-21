# create app runner using the NGINX image in the NGINX ECR repository
resource "aws_apprunner_service" "MyAppService" {
    service_name = "${var.prefix}-MyAppService"
    source_configuration {
        image_repository {
            image_configuration {
                port = "80"
            }
            image_identifier      = "859079231122.dkr.ecr.eu-west-1.amazonaws.com/nginx:latest"
            image_repository_type = "ECR"
        }
        auto_deployments_enabled = false
        authentication_configuration {
            access_role_arn = var.ECRPRoleArn
            
        }
    }
    
    instance_configuration {
        cpu    = "1024"
        memory = "2048"
    }
    tags = {
        Name = "${var.prefix}-MyAppService"
    }
    
}

