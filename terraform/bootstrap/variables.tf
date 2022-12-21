variable location         { 
    type = string
    description = "Azure Region location code"
    default = "uksouth"

 }

 variable "default_tags" {
    type = map(string)
    description = "Default tags used on all resources for example Bitbucket repo, build num etc"
    default = {
      "developer" = "shadders"
    }
}

