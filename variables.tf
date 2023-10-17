variable "tags" {
  type        = map(string)
  description = "Common tags to be used by all resources"
}

variable "github_repositories" {
  type        = list(string)
  description = "The github repositories, for example [\"ministryofjustice/modernisation-platform-environments:*\"]"
  validation {
    condition     = length(var.github_repositories) > 0
    error_message = "At least one repository must be specified."
  }

}

variable "role_name" {
  type        = string
  description = "Name of role"

  validation {
    condition     = length(var.role_name) > 0 && length(var.role_name) < 65
    error_message = "Role name must have the minimum length of 1 and maximum length of 64 characters."
  }
}

variable "policy_arns" {
  type        = list(string)
  description = "List of policy ARNs for the assumable role. Defaults to [\"arn:aws:iam::aws:policy/ReadOnlyAccess\"]"
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

variable "policy_jsons" {
  type        = list(string)
  description = "List of policy jsons for the assumable role. Defaults to []"
  default     = []
  validation {
    condition = alltrue([
      for jsn in var.policy_jsons : can(jsondecode(jsn))
    ])
    error_message = "All supplied policies must be valid json."
  }
}

variable "subject_claim" {
  type        = string
  description = "Github OIDC subject claim, defaults to *"
  default     = "*"
}

variable "max_session_duration" {
  type        = number
  description = "The maximum session duration (in seconds) that you want to set for the specified role. Defaults to 3600"
  default     = 3600
  validation {
    condition     = var.max_session_duration > 0 && var.max_session_duration <= 43200
    error_message = "Max session duration must be between 1 and 43200 seconds."
  }
}
