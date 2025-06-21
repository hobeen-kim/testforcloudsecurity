variable "tags" {
  type    = map(string)
  default = {}
}

variable "target_port" {
  type = number
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "my_ip" {
  type = string
}

variable "user_data" {
  description = "User data script to run on instance boot"
  type        = string
  default     = <<-EOT
    #!/bin/bash
    dnf install -y java-17-amazon-corretto

    # download jar
    aws s3 cp s3://java-repository-589794546244/testforcloudsecurity.jar /tmp/testforcloudsecurity.jar

    # run jar
    nohup java -jar /tmp/testforcloudsecurity.jar > /tmp/app.log 2>&1 &
  EOT
}