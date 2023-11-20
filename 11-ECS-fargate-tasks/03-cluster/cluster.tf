
# create cluster
resource "aws_ecs_cluster" "cluster" {
  name = "my-cluster"
  

}
resource "aws_ecs_service" "service" {
  name            = "my-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = var.task_def_arn
  desired_count   = 4
  launch_type     = "FARGATE"
  

  network_configuration {
    assign_public_ip = true
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
  }
}


