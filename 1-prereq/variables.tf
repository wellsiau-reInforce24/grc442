variable "ct_management_acc_id" {
  type        = string
  description = "AWS Control Tower Management account id"
}

variable "ct_management_sso_admin_role" {
  type        = string
  description = "IAM Identity Center role ARN used to administer Control Tower Management Account"
}