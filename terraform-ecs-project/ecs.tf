# ---------------- ECS TASK EXECUTION ROLE ----------------

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "sid1901-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Name = "sid1901-ecs-task-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ---------------- ECS CLUSTER ----------------

resource "aws_ecs_cluster" "main" {
  name = "sid1901-ecs-cluster"

  tags = {
    Name = "sid1901-ecs-cluster"
  }
}

# ---------------- ECS TASK DEFINITION ----------------

resource "aws_ecs_task_definition" "app" {
  family                   = "sid1901-app-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  cpu    = "256"
  memory = "512"

  container_definitions = jsonencode([
    {
      name      = "sid1901-app"
      image     = "nginx:latest"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}
