output "role" {
  value = module.module_test.role
}

output "role_trust_policy_conditions" {
  value = jsondecode(module.module_test.role_trust_policy).Statement[*].Condition.StringLike
}

output "role_trust_policy_conditions_with_subject_claim" {
  value = jsondecode(module.module_test_with_subject_claim.role_trust_policy).Statement[*].Condition.StringLike
}

output "role_additional_permissions_policy" {
  value = module.module_test.role_additional_permissions_policy
}
