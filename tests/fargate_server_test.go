package test

import (
    "testing"
    "time"
    "github.com/gruntwork-io/terratest/modules/http-helper"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "crypto/tls"
)
func TestFargate(t *testing.T) {
  terraformOptions := &terraform.Options {
    TerraformDir: "../terraform/aws",
  }
  url := terraform.Output(t, terraformOptions, "url")
  status := 200
  text := "nginx"
  retries := 15
  sleep := 5 * time.Second
  tlsConfig := tls.Config{}
  http_helper.HttpGetWithRetry(t, url, &tlsConfig, status, text, retries, sleep)
}
