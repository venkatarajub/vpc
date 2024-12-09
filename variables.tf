variable "common_tags" {
    default = {
        project = "expense"
        terraform = "true"
    }
}

variable "project" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "public_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.11.0/24"]
}

variable "private_cidrs" {
    type = list
    default = ["10.0.2.0/24", "10.0.22.0/24"]
}

variable "db_cidrs" {
    type = list
    default = ["10.0.3.0/24", "10.0.33.0/24"]
}
