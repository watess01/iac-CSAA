

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
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
 }

