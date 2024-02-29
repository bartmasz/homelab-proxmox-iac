# My Home Server IaC

This repository contains Terraform Infrastructure as a Code to build Proxmox templates, virtual machines and containers used on my home server.

## Configuration

Terraform [bpg proxmox provider](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) allows to use Token or SSH authentication. I'm using SSH as it allows to perform all required operations.

Credentials are stored in `.env` file and automatically loaded by [dotenv plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dotenv).

```bash
# .env example
PROXMOX_VE_ENDPOINT="https://a.b.c.d:8006"
PROXMOX_VE_USERNAME="root@pam"
PROXMOX_VE_PASSWORD="YourRootPasswordHere"
```

Other required configurations are defined in `variables.tf`. Most of them have defaults. Other variables or overrides can be defined in `iac.tfvars`.

```ini
# ioc.tfvars example
proxmox_node = "node-name"
```

## Apply and destroy infrastructure

```bash
# initialize terraform project
terraform init

# apply infrastructure
terraform apply -var-file iac.tfvars

# destroy infrastructure
terraform destroy -var-file iac.tfvars
```
