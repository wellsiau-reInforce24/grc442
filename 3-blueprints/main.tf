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
    template_url                = "https://reinforce-grc442-artifact.s3.amazonaws.com/isv_product_roles-v2024-06-10_08_50_26.tar.gz"
    disable_template_validation = true
  }
}

# aws service catalog provisioning artifact
resource "aws_servicecatalog_provisioning_artifact" "v2" {
  name                        = "v2"
  description                 = "v2"
  type                        = "EXTERNAL"
  product_id                  = aws_servicecatalog_product.blueprints.id
  disable_template_validation = true
  template_url                = "https://reinforce-grc442-artifact.s3.amazonaws.com/isv_product_roles-v2024-06-10_08_51_50.tar.gz"
}