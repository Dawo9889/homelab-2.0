terraform {
  backend "s3" {
    bucket   = "terraform-states" # Name of the S3 bucket
    endpoint = "https://s3.dawo9889-homelab.ovh"
    key      = "homelab.tfstate" # Name of the tfstate file

    # AWS_ACCESS_KEY_ID from env injected
    # AWS_SECRET_ACCESS_KEY from env


    region                      = "main" # Region validation will be skipped
    skip_credentials_validation = true   # Skip AWS related checks and validations
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}