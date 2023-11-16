

# create a task definition for ECS
resource "aws_ecs_task_definition" "web" {
  family                   = "my-nginx"
  
  container_definitions    = jsonencode([
  {
    name = "nginx"
    image = "nginx:latest"
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
        protocol      = "tcp"
      }
    ]
  }])


  # use fargate serverless app environment
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = "256"
    memory                   = "512"
    # set task execution role to ecsTaskExecutionRole
    # execution_role_arn       = "arn:aws:iam::859079231122:role/ecsTaskExecutionRole"
    

  


 }


# create a cluster for ECS