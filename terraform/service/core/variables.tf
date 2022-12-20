variable location         { 
    type = string
    description = "Azure Region location code"

 }

 variable environment         {
    type = string
    description = "environment for the service"
 
 }

variable service_name {
    type = string
    description = "logical service name of the component within the deployment"

 }

 variable "default_tags" {
    type = map(string)
    description = "Default tags used on all resources for example Bitbucket repo, build num etc"
  
}

