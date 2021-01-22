# Create ECS Cluster
resource "aws_ecs_cluster" "villvay" {
  name               = var.cluster_name
  capacity_providers = ["FARGATE"]
}

# Create Task Definition
resource "aws_ecs_task_definition" "villvay" {
  family                = var.prefix
  container_definitions = file("./container.json")
  execution_role_arn       = var.execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
}

# Create a ECS service with Above created task definition
resource "aws_ecs_service" "villvay" {
  name            = var.prefix
  cluster         = aws_ecs_cluster.villvay.id
  task_definition = aws_ecs_task_definition.villvay.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = 80
  }

  network_configuration {
    subnets          = var.subnet_id
    security_groups  = var.network_security_groups
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }
}