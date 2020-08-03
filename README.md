# Terraform + Libvirt-Provider-Plugin Docker Container

The [Terraform libvirt Provider Plugin](https://github.com/dmacvicar/terraform-provider-libvirt) is an unofficial [Terraform](https://www.terraform.io/) provider plugin for using Terraform to setup Linux QEMU / KVM machines.

This Docker image is meant to provide an easy and reproducible setup for performing Terraform tasks in KVM setups.

Example usage:

```shell
docker run --rm -v $(PWD):/var/tfproject rgielen/terraform-libvirt terraform <command> 
```

## Available Tags

`latest`,`0.12.29`,`0.12` - Terraform 0.12.29 + terraform-provider-libvirt 0.6.2
