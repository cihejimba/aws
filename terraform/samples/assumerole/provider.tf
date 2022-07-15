provider aws {
  region = "us-east-1"
  profile = "terraform"
  
  assume_role {
    role_arn = "arn:aws:iam::199603965279:role/terraform"
    session_name = "terraform-session"
  }
}

