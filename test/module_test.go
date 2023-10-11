package main

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"regexp"
	"testing"
)

func TestModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	role := terraform.Output(t, terraformOptions, "role")
	role_trust_policy_conditions := terraform.Output(t, terraformOptions, "role_trust_policy_conditions")
	role_trust_policy_conditions_with_subject_claim := terraform.Output(t, terraformOptions, "role_trust_policy_conditions_with_subject_claim")

	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::\d{12}:role/modernisation-platform-github-actions`), role)
	require.Equal(t, role_trust_policy_conditions, "[map[token.actions.githubusercontent.com:sub:[repo:ministryofjustice/modernisation-platform-environments:* repo:ministryofjustice/modernisation-platform:*]]]")
	require.Equal(t, role_trust_policy_conditions_with_subject_claim, "[map[token.actions.githubusercontent.com:sub:[repo:ministryofjustice/modernisation-platform-environments:pull_request repo:ministryofjustice/modernisation-platform:pull_request]]]")
}
