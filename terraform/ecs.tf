resource "aws_ecs_cluster" "main" {
  name = "three-tier-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-service"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "web"
      image     = "public.ecr.aws/docker/library/node:18-alpine"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "app-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.private_1a.id, aws_subnet.private_1b.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn
    container_name   = "web"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.http]
}
