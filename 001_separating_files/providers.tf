
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  alias = "eu_aws"
}