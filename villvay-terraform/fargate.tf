# Create ECS Cluster
resource "aws_ecs_cluster" "villvay" {
  name               = "villvay-cluster"
  capacity_providers = ["FARGATE"]
}

# Create Task Definition
resource "aws_ecs_task_definition" "villvay" {
  family                = "villvay"
  container_definitions = file("./container.json")
  #   task_role_arn = "arn:aws:iam::111960289902:role/ecsTaskExecutionRole"
  execution_role_arn       = "arn:aws:iam::111960289902:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
}

# Create a ECS service with Above created task definition
resource "aws_ecs_service" "villvay" {
  name            = "villvay"
  cluster         = aws_ecs_cluster.villvay.id
  task_definition = aws_ecs_task_definition.villvay.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = "arn:aws:elasticloadbalancing:us-west-2:111960289902:targetgroup/farget-lb-traget/cd827d19849bf44c"
    container_name   = "villvay-nginx"
    container_port   = 80
  }

  network_configuration {
    subnets          = ["subnet-064365433e8d76ff8"]
    security_groups  = ["sg-0c1917de8cd27b6a9"]
    assign_public_ip = true
  }

  deployment_controller {
    type = "ECS"
  }
}