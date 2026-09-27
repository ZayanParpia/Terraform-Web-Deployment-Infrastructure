# ============================================================
# Terraform Variables
# ============================================================

# ============================================================
# Availability Zones
# ============================================================

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones to deploy resources across"
  default     = ["us-east-1a", "us-east-1b"]
}