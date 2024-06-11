run "basic_validation" {
  command = apply

  variables {
    enable_security_scanner = true
    enable_finops_scanner   = true
  }

  assert {
    condition     = tolist(tolist(data.aws_iam_policy_document.security_scanner.statement[0].principals)[0].identifiers)[0] == "397352175627"
    error_message = "Invalid assume role principal for security scanner role"
  }

  assert {
    condition     = tolist(tolist(data.aws_iam_policy_document.finops_scanner.statement[0].principals)[0].identifiers)[0] == "912606485646"
    error_message = "Invalid assume role principal for finops scanner role"
  }
}
