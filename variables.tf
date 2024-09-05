# Copyright 2024, identinet GmbH. All rights reserved.
# SPDX-License-Identifier: MIT

variable "hcloud_token" {
  description = "Hetzner cloud auth token."
  type        = string
  sensitive   = true
}

variable "hcloud_token_read_only" {
  description = "Hetzner cloud auth token, read only - used by the gateway and all cluster servers to proxy kubernetes traffic to control plane nodes."
  type        = string
  sensitive   = true
}

# Cluster Settings
# ----------------

variable "delete_protection" {
  description = "Prevent cluster nodes from manual deletion. Is lifted automatically when cluster is destroyed. See https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server#delete_protection"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Cluster name (prefix for all resource names)."
  type        = string
  default     = "hetzner"
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.cluster_name))
    error_message = "Cluster name must only contain characters allowed in DNS names (`^[a-z0-9-]+$`)."
  }
}

variable "default_location" {
  description = "Default location for Hetzner servers if not specified in the node pool + location of the gateway, see https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server#location"
  type        = string
  default     = "nbg1"
}

variable "k3s_channel" {
  description = "k3s channel (stable, latest, v1.19 and so on, see https://update.k3s.io/v1-release/channels)."
  type        = string
  default     = ""
}

variable "k3s_version" {
  description = "k3s version, if set, takes presdence over k3s_channel, see https://github.com/k3s-io/k3s/tags."
  type        = string
  default     = ""
}

variable "default_image" {
  description = "Default server image if not specified in the node pool + image of the gateway. See `HCLOUD_TOKEN=XXXX; curl -H \"Authorization: Bearer $HCLOUD_TOKEN\" https://api.hetzner.cloud/v1/images | jq -r .images[].name | sort`"
  type        = string
  default     = "ubuntu-22.04"
}

variable "oidc_enabled" {
  description = "Configure OpenID Connect authentication for the cluster."
  type        = bool
  default     = false
}

variable "oidc_issuer_url" {
  description = "URL of the provider which allows the API server to discover public signing keys. Only URLs which use the https:// scheme are accepted. This is typically the provider's discovery URL without a path, for example \"https://accounts.google.com\" or \"https://login.salesforce.com\". This URL should point to the level below .well-known/openid-configuration."
  type        = string
  default     = ""
}

variable "oidc_client_id" {
  description = "The OpenID Connect client id, a public identifier of this application/cluster."
  type        = string
  default     = ""
}

variable "oidc_client_secret" {
  description = "The OpenID Connect client secret of this application/cluster."
  sensitive   = true
  type        = string
  default     = ""
}

# General Settings
# ----------------

variable "create_scripts" {
  description = "Create scripts to configure the kubectl context for the cluster."
  type        = bool
  default     = true
}

variable "network_cidr" {
  description = "CIDR of the private network."
  type        = string
  default     = "10.0.0.0/8"
}

variable "network_zone" {
  description = "Network zone, eu-central, us-east, us-west."
  type        = string
  default     = "eu-central"
}

variable "subnet_cidr" {
  description = "CIDR of the private network."
  type        = string
  default     = "10.0.1.0/24"
}

variable "cluster_cidr_network_offset" {
  description = "Cluster network offset."
  type        = number
  default     = 244
}

variable "cluster_cidr_network_bits" {
  description = "Cluster network CIDR bits."
  type        = number
  default     = 16
}

variable "service_cidr_network_offset" {
  description = "Service CIDR."
  type        = number
  default     = 43
}

variable "service_cidr_network_bits" {
  description = "Service network CIDR bits."
  type        = number
  default     = 16
}

variable "enable_public_net_ipv4" {
  description = "Enable the assignment of a public IPv4 address (increases the costs per month)."
  type        = bool
  default     = false
}

variable "enable_public_net_ipv6" {
  description = "Enable the assignment of a public IPv6 address (increases the costs per month)."
  type        = bool
  default     = false
}

variable "ssh_keys" {
  description = "Map of public ssh keys."
  type        = map(string)
}

variable "cilium_version" {
  description = "Cilium version, see https://github.com/cilium/cilium"
  type        = string
  default     = "1.15.1"
}

variable "kured_chart_version" {
  description = "Kured chart version, see https://artifacthub.io/packages/helm/kured/kured"
  type        = string
  default     = "5.4.1"
}

variable "kured_reboot_days" {
  description = "Kured system reboot days, see https://kured.dev/docs/configuration/#setting-a-schedule"
  type        = string
  default     = "mo,tu,we,th,fr,sa,su"
}

variable "kured_start_time" {
  description = "Kured system reboot start time, see https://kured.dev/docs/configuration/#setting-a-schedule"
  type        = string
  default     = "1am"
}

variable "kured_end_time" {
  description = "Kured system reboot end time, see https://kured.dev/docs/configuration/#setting-a-schedule"
  type        = string
  default     = "5am"
}

variable "hcloud_ccm_driver_chart_version" {
  description = "Hetzner CCM chart version, see https://github.com/hetznercloud/hcloud-cloud-controller-manager#versioning-policy"
  type        = string
  default     = "1.19.0"
}

variable "hcloud_csi_driver_chart_version" {
  description = "Hetzner CSI driver chart version, see https://github.com/hetznercloud/csi-driver/blob/main/docs/kubernetes/README.md#versioning-policy"
  type        = string
  default     = "2.6.0"
}

variable "metrics_server_chart_version" {
  description = "Metrics server chart version, see https://artifacthub.io/packages/helm/metrics-server/metrics-server"
  type        = string
  default     = "3.11.0"
}

variable "system_upgrade_controller_version" {
  description = "System Upgarde Controller version, see available versions https://github.com/rancher/system-upgrade-controller and https://github.com/rancher/charts/tree/dev-v2.9/charts/system-upgrade-controller"
  type        = string
  default     = "103.0.0+up0.6.0"
}

variable "nu_version" {
  description = "NuShell version"
  type        = string
  default     = "0.90.1"
}

variable "additional_packages" {
  description = "List of packages to install on all servers."
  type        = list(string)
  default     = []
}

variable "additional_runcmd" {
  description = "List of additional shell commands to append to the cloud-init runcmd section on all servers."
  type        = list(any)
  default     = []
}

variable "additional_cloud_init" {
  description = "Additional cloud-init configuration as a map that will be appended to user_data on all servers. You can use this to supply additional configuration or override existing keys."
  type = object({
    timezone = optional(string, "Europe/Berlin")
    locale   = optional(string, "en_US.UTF-8")
    users = optional(list(object({
      name          = string
      gecos         = string
      groups        = string
      lock_passwd   = bool
      shell         = string
      ssh_import_id = list(string)
      sudo          = list(string)
    })), [])
  })
}

# Gateway Settings
# ----------------

variable "gateway_firewall_ids" {
  description = "A list of firewall IDs to apply on the gateway."
  type        = list(number)
  default     = []
}

variable "gateway_firewall_icmp_open" {
  description = "Allow ping."
  type        = bool
  default     = true
}

variable "gateway_firewall_k8s_open" {
  description = "Open kubernetes port to the Internet. If it's not open, SSH port fowarding should be used gain access to the cluster."
  type        = bool
  default     = false
}

variable "gateway_server_type" {
  description = "Gateway node type (size)."
  type        = string
  default     = "cx11"
  validation {
    condition     = can(regex("^(cp?x[1-5][1-2]|cax[1-4]1|ccx[1-6]3)$", var.gateway_server_type))
    error_message = "Node type is not valid."
  }
}

variable "gateway_labels" {
  description = "Hetzner server labels for gateway."
  type        = map(string)
  default     = {}
}

# Control Plane Settings
# ----------------------

variable "control_plane_firewall_ids" {
  description = "A list of firewall IDs to apply on the control plane nodes."
  type        = list(number)
  default     = []
}

variable "control_plane_k3s_init_additional_options" {
  description = "Additional options passed to the control plane node that initializes the cluster during installation."
  type        = string
  default     = ""
}

variable "control_plane_k3s_additional_options" {
  description = "Additional options passed to all control plane nodes during installation."
  type        = string
  default     = ""
}

# Node Pool Settings
# ------------------

variable "node_pools" {
  description = <<-EOT
Map of node pools with control plane and worker nodes.
Key is the node pool's name.
Value an object specifying:
- `is_control_plane`: whether it's a control plane pool. Note: don't change this
  variable after the node pool has been deployed!
- `schedule_workloads:` whether and workloads can be scheduled, Note: a change
  of this variable will only affect newly created nodes. So, don't change this
  variable after the node pool has been deployed!
- `location`: defines the server location. If not set, `default_location` is used,
  see https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server#location.
  Note: a change of this variable will only affect newly created nodes. So,
  don't change this variable after the node pool has been deployed!
- `image[]`: defines the operating system image. If not set, `default_image` is used.
  Note: a change of this variable will only affect newly created nodes. So,
  don't change this variable after the node pool has been deployed!
- `type`: defines the server type, see https://docs.hetzner.com/cloud/servers/overview#shared-vcpu
  Note: a change of this variable will cause a redeployment of the whole pool!
  If this is a control plane pool, mind the initialization settings!
- `count`: defines the nubmer of nodes. Note: before reducing this count and
  running `terraform apply`, drain and delete the nodes from kubernetes. The
  nodes will be removed in descending order - highest number first.
- `count_width`: defines the width of the number in the nodes' names. If the node's
  number is doesn't fill the whole width, it is left-padded with 0s. Note:  a change
  of this variable will only affect newly created nodes. So, don't change this
  variable after the node pool has been deployed!
- `labels`: defines node labels that will be applied to hetzner console and
  kubernetes. Note: changes to this variable won't affect kubernetes labels of
  existing nodes!
- `taints`: defines kubernetes taints,
  see https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/
- Note: changes to this variable won't affect tains of
  existing nodes!
- `cluster_can_init`: defines whether the first node of the control plane pool
  can initialize the cluster. Exactly one node pool must set this variable to
  `true`.
- `cluster_init_action`: defines the initialization action that shall be performed
  - `init`, required for the first run of `terraform apply`. For later runs it
     should be set to `false` to prevent any accidential reinitialization of the
     cluster, e.g. when the first node of this pool is manually deleted via
     the management console. Note: changes to this variable won't affect
     existing nodes. So, if a reinitialization shall be performed, first delete
     the node from the cluster and then run `terraform apply` again.
  - `reset`: required for reinitializing the cluster to an older state.
  - `reset_restore_path`: is the name or path to the etcd backup, see
     https://docs.k3s.io/cli/etcd-snapshot?_highlight=reset

Example:
```
node_pools = {
  system = {
    cluster_can_init = true # Required for one node pool to perform initializing actions.
    cluster_init_action = {
      # `init` must be `true` for the first call of `terraform apply.
      # For later runs it should be set to `false` to prevent any accidential
      # reinitialization of the cluster, e.g. when the first node of this pool
      # is manually deleted via the management console.
      init = true,
    }
    is_control_plane   = true
    schedule_workloads = true
    location           = "nbg1"
    image              = "ubuntu-22.04"
    type               = "cx21" # See available types https://docs.hetzner.com/cloud/servers/overview#shared-vcpu
    count              = 3
    count_width        = 1
    labels = {
      # "my" = "label"
    }
    taints = {
      # "MyTaint=true" = "NoSchedule"
    }
  }
  workers = {
    is_control_plane   = false
    schedule_workloads = true
    location           = "nbg1"
    image              = "ubuntu-22.04"
    type               = "cx21" # See available types https://docs.hetzner.com/cloud/servers/overview#shared-vcpu
    count              = 3
    count_width        = 2
    labels             = {}
    taints             = {}
  }
}
```
EOT
  type = map(object({
    cluster_can_init = optional(bool, false),
    cluster_init_action = optional(object({
      init               = optional(bool, false),
      reset              = optional(bool, false)
      reset_restore_path = optional(string, "")
    }), {}),
    is_control_plane   = optional(bool, false),
    schedule_workloads = optional(bool, true),
    location           = optional(string, ""),
    image              = optional(string, ""),
    type               = string,
    count              = number,
    count_width        = optional(number, 1),
    labels             = map(string),
    taints             = map(string)
  }))
  default = {}
  validation {
    condition     = alltrue([for pool in var.node_pools : pool.count > 0])
    error_message = "`count` must be greater or equal to 1."
  }
  validation {
    condition     = alltrue([for pool in var.node_pools : pool.count_width > 0])
    error_message = "`count_width` must be greater or equal to 1."
  }
  validation {
    condition     = alltrue([for pool in var.node_pools : (!pool.schedule_workloads && pool.is_control_plane) || pool.schedule_workloads])
    error_message = "`schedule_workloads` can only be set to false for control plane node pools."
  }
  validation {
    condition     = anytrue([for pool in var.node_pools : pool.is_control_plane])
    error_message = "There must be at least one control plane node pool, i.e. `is_control_plane = true`."
  }
  validation {
    condition     = length([for pool in var.node_pools : pool.cluster_can_init if pool.cluster_can_init && pool.is_control_plane]) == 1
    error_message = "`cluster_can_init` must be set to `true` for exactly one control plane node pool."
  }
  validation {
    condition = alltrue([for pool in var.node_pools :
      (!pool.cluster_init_action.init || !pool.cluster_init_action.reset) if pool.cluster_can_init
    ])
    error_message = "`cluster_init_action.init` and `cluster_init_action.reset` can not be true at the same time."
  }
  validation {
    condition = alltrue([for pool in var.node_pools :
      (pool.cluster_init_action.reset && pool.cluster_init_action.reset_restore_path != "") if pool.cluster_can_init && pool.cluster_init_action.reset
    ])
    error_message = "`cluster_init_action.reset` requires `cluster_init_action.reset_restore_path` to be non-empty."
  }
}

variable "worker_node_firewall_ids" {
  description = "A list of firewall IDs to apply on the work node servers."
  type        = list(number)
  default     = []
}
