variable "region" {
    default = " ap-south-1"

}

variable "bucket-env-prefix" {
    default = "dev"
}

variable "ec2_prefix"{
    default =  "dev"
}

variable "instance_count"{
    default =  1
}

variable "cidr_block"{
   type = list(string)
   default =  ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]

}


variable "config" {
    type = object({
      region = string
      monitoring = bool
      instance_count = number
    })
    default = {
      region = "ap-south-1",
      monitoring =  true,
      instance_count = 1

    }
}