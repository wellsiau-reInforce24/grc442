provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::955372440160:role/AWSControlTowerExecution"
  }

  default_tags {
    tags = {
      EventName = "reinforce-grc442"
    }
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
        "arn:aws:iam::${var.ct_management_acc_id}:role/service-role/AWSControlTowerAdmin",
        "${var.ct_management_sso_admin_role}"
      ]
    }
  }
}
