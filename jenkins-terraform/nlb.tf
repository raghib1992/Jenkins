data "aws_subnet" "default" {
  filter {
    name   = "tag:Name"
    values = ["Default"]
  }
}

output "subnet" {
    value = data.aws_subnet.default.id
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "network"
  
  subnet_mapping {
    subnet_id            = data.aws_subnet.default.id
    # private_ipv4_address = "10.0.1.15"
  }

#   enable_deletion_protection = true

  tags = {
    Environment = "test"
  }
}

resource "aws_lb_target_group" "ec2-nlb-target-group" {
    name                = "ec2-nlb-target-group"
    vpc_id              = data.aws_vpc.default_vpc.id
    port                = "443"
    protocol            = "TCP"
    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "5"
        path                = var.nlb_http_health_checks_enabled ? "/tracker/status" : null
        interval            = "10"
        port                = "8080"
        protocol            = var.nlb_http_health_checks_enabled ?  "HTTP" : "TCP"
    }
    
    # deregistration_delay = 300

    # tags = merge(
    #          local.common_tags,
    #          {
    #            Name = "${var.name_prefix}-ec2-nlb-target-group"
    #          }
    # )
}

data "aws_vpc" "default_vpc" {
  id = "vpc-bca38cd5"
}