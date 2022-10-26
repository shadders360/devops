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

variable deployment_number {
    type = string
    description = "number indicating the deployment. Incremented if additional deployments required"
   
 }

 variable "api_token"  {
    type = string
    description = "instana API token to connect to cloud service via REST api"
 }

  variable "api_endpoint"  {
    type = string
    description = "instana API endpoint URL "
 }