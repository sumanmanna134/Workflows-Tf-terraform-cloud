variable "env" {
  type    = string
  default = "dev"

}

variable "location_map" {
  type = map(string)
  default = {
    "dev"     = "Central India",
    "prod"    = "South India",
    "staging" = "North India"
  }

}

variable "subnet_names" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]

}

variable "client_id" {


}
variable "client_secret" {

}

variable "tenant_id" {

}

variable "subscription_id" {

}

