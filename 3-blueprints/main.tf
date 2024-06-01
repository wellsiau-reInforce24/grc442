# random string lenght 6
resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

# aws service catalog product
resource "aws_servicecatalog_product" "blueprints" {
  name        = "grc442-r1-${random_string.random.result}"
  owner       = "grc442-r1"
  description = "sample blueprints"
  distributor = "grc442"
  type        = "EXTERNAL"

  provisioning_artifact_parameters {
    name                        = "v1"
    description                 = "v1"
    type                        = "EXTERNAL"
    template_url                = "https://reinforce-grc442-artifact.s3.amazonaws.com/isv_iam_roles-v2024-06-01_13_59_58.tar.gz"
    disable_template_validation = true
  }
}