terraform {
  /* required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }

  } */
}


provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  alias = "eu_aws"
}

locals {
  instance_type   = var.instance_type
  app_server_tags = "APP Server"
  enum_instances = [
    "nano",
    "micro",
    "mini"
  ]
}


variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "instances_map" {
  type = map
  default = {
    nano="t2.nano"
    micro="t2.micro"
    mini="t2.mini"
  }
}

variable "anotherMap" {
  type = map
  default = {
    "nano_K":"nano_V"
    "mini_K":"mini_V"
  }
}

variable "as" {
  
}

variable "anotherList" {
  type = list(object({
    id=string
  }))
  default = [
    {id="1"},
    {id="2"},
    {id="3"},
    {id="4"}
  ]
}





output "string_ops_interpolation" {
  value = "Hello ${var.instance_type}"
}

output "string_ops_directives" {
  value = "Hello %{if var.instance_type== "t2.nano"}nano%{else}micro%{endif}"
}

output "forloop" {
    value =  [for e in local.enum_instances : upper(e)]
}

output "instances_map" {
  value = var.instances_map
}

output "instances_map_1" {
  value = var.anotherMap
}

output "map_for_loop"{
  value = [for k,v in var.anotherMap : upper(v)]
}

output "map_for_loop_ab"{
  value = [for a,b in var.anotherMap : upper(a)]
}

output "map_for_loop_hashrocket"{
  value = {for i,w in var.anotherMap : "${i}" => upper(w)}
}

output "anotherListop" {
  value = [var.anotherList[*].id ]
}

