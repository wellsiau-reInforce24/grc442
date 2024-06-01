provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::955372440160:role/AWSControlTowerExecution"
  }
}

# iam role with assume role document
resource "aws_iam_role" "blueprint_afc" {
  name               = "AWSControlTowerBlueprintAccess"
  assume_role_policy = data.aws_iam_policy_document.blueprint_afc.json
  path               = "/"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AWSServiceCatalogAdminFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

# data iam policy document for assume role
data "aws_iam_policy_document" "blueprint_afc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::164368139081:role/AWSControlTowerExecution",
        "arn:aws:iam::164368139081:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AWSAdministratorAccess_f39f7c68c949bbc5"
      ]
    }
  }
}
