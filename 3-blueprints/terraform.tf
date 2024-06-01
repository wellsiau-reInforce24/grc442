terraform {
  cloud {
    organization = "wellsiau-org"
    workspaces {
      name = "grc442-r1-blueprints"
    }
  }
}