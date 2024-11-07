# Copyright 2024, identinet GmbH. All rights reserved.
# SPDX-License-Identifier: MIT

terraform {
  required_providers {
    # See Version Constraints: https://developer.hashicorp.com/terraform/language/expressions/version-constraints
    hcloud = {
      # Documentation; https://registry.terraform.io/providers/hetznercloud/hcloud
      source  = "hetznercloud/hcloud"
      version = "~> 1.49.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.12.0"
    }
  }
  required_version = "~> 1.0"
}

provider "hcloud" {
  token = var.hcloud_token
}
