provider "aws" {
  profile = "default"
  alias   = "east-2"
  region  = "us-east-2"
}

provider "aws" {
  profile = "default"
  alias   = "east-1"
  region  = "us-east-1"
}
