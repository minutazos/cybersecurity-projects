variable "region" {
    default = "eu-west-3"
}
variable "internal_vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "internal_public_subnet" {
    default = "10.0.1.0/24"
}
variable "internal_private_subnet" {
    default = "10.0.2.0/24"
}
variable "internal_private_subnet_1" {
    default = "10.0.3.0/24"
}
variable "acceptance_vpc_cidr" {
    default = "10.1.0.0/16"
}
variable "acceptance_public_subnet" {
    default = "10.1.1.0/24"
}
variable "acceptance_private_subnet_front" {
    default = "10.1.2.0/24"
}
variable "acceptance_private_subnet_back" {
    default = "10.1.3.0/24"
}
variable "acceptance_private_subnet_pu" {
    default = "10.1.4.0/24"
}
variable "production_vpc_cidr" {
    default = "10.2.0.0/16"
}
variable "production_public_subnet" {
    default = "10.2.1.0/24"
}
variable "production_front_subnet" {
    default = "10.2.2.0/24"
}
variable "production_back_subnet" {
    default = "10.2.3.0/24"
}
variable "production_pu_subnet" {
    default = "10.2.4.0/24"
}
variable "test_vpc_cidr" {
    default = "10.3.0.0/16"
}
variable "test_public_subnet" {
    default = "10.3.1.0/24"
}
variable "test_private_subnet_front" {
    default = "10.3.2.0/24"
}
variable "test_private_subnet_back" {
    default = "10.3.3.0/24"
}
variable "test_private_subnet_pu" {
    default = "10.3.4.0/24"
}
variable "ami" {
    default = "ami-051806c39fa542e22"
}
variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}
variable "postgres_username" {
    default = "dbuser"
}
variable "postgres_password" {
    default = "password"
}

