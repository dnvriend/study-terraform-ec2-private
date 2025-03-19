terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.91"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "dev"
      Terraform   = "true"
      Project     = "study-terraform-ec2-private"
      Owner       = "dnvriend"
    }
  }
}
