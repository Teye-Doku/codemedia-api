locals {
  min_size = 2
  max_size = 3
  http_port     = 80
  http_protocol = "tcp"
  any_port      = 0
  any_protocol  = "-1"
  all_ips       = ["0.0.0.0/0"]
}

data "aws_availability_zones" "all" {}

resource "aws_autoscaling_group" "yel_asg" {
  launch_configuration = aws_launch_configuration.yel_lc.id
  availability_zones   = data.aws_availability_zones.all.names
  load_balancers       = [aws_elb.yel_elb.id]
  health_check_type    = "ELB"

  min_size = local.min_size
  max_size = local.max_size


  tag {
    key                 = "Name"
    value               = "yellofix-instances"
    propagate_at_launch = true
  }


}


resource "aws_elb" "yel_elb" {
  name               = "yellofix-elb"
  availability_zones = data.aws_availability_zones.all.names
  security_groups    = [aws_security_group.yel_elb_security.id]



  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = var.server_port
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}



resource "aws_security_group" "yel_elb_security" {
  name = "yel_instance_security"

  ingress {
    from_port    = local.http_port
    to_port      = local.http_port
    protocol     = local.http_protocol
    cidr_blocks = local.all_ips
  }


  egress {
    from_port    = local.any_port
    to_port      = local.any_port
    protocol     = local.any_protocol
    cidr_blocks = local.all_ips
  }

}
data "aws_ami" "codemedia-ami" {
 most_recent = true
 owners = ["self"] 

 filter {
    name = "name"
    values = ["codemedia-ec2-*"]
 }
}

resource "aws_launch_configuration" "yel_lc" {
  name            = "yel_lc"
  image_id        = data.aws_ami.codemedia-ami.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.yel_lc_security.id]
  user_data       =  data.template_file.user_data.rendered


}

data "template_file" "user_data" {
  template = file("${path.module}/webserver.sh")
  

  vars = {
    server_port = var.server_port
  }
}

resource "aws_security_group" "yel_lc_security" {
  name = "yel_lc_instance_security"

  ingress {
    from_port    = var.server_port
    to_port      = var.server_port
    protocol     = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


}




