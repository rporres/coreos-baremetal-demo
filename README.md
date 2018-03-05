# CoreOS Container Linux provisioning using Terraform, Dnsmasq, Matchbox and Ignition

This repo contains a files to provision CoreOS servers using [Terraform](https://www.terraform.io/), [dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html), [Matchbox](https://coreos.com/matchbox/docs/latest/), [Ignition](https://coreos.com/ignition/docs/latest/). It uses Vagrant over VirtualBox for demoing purposes.

The following example will provision the three servers of an etcd cluster

This demo was part of a talk. Here are the [slides](http://bit.ly/2nCCgoa)


## Pre-requisistes

* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/wiki/VirtualBox)

## Instructions

### Provisioner server

The provisioner server runs:

* dnsmasq: DHCP and DNS server. [Configuration file](./files/dnsmasq.conf.envsubst.tpl) won't use PXE-iPXE chainloading as we will use an iPXE boot loader
* Matchbox: iPXE, assets and ignition files server

In order to provision it we use a [Vagrantfile](./Vagrantfile). A [post-installation script](./scripts/provision.sh) takes care of:

* Configuring NAT
* Configuring dnsmasq
* Configuring Matchbox
* Download Terraform and non-standard providers

It has two interfaces:

* A NAT interface that connects to the internet
* An internal interface where demo servers will run

In order to boot it, just type

```
vagrant up
```

Once booted, in order to configure Matchbox through Terraform:

```
vagrant ssh
cd /vagrant/terraform/environment
terraform init
terraform plan -out plan.out
terraform apply plan.out
```

### etcd servers

Download the [iPXE boot iso](http://boot.ipxe.org/ipxe.iso) that will be used.

Create three Linux servers in VirtualBox:

* Type: Linux 2.6 or higher
* Network: Internal (attach it to the internal network created by the Vagrantfile)
* Mac addresses: Set them to be:
  * `080027ab1001`
  * `080027ab1002`
  * `080027ab1003`
* IDE: Attach the `ipxe.iso` file that you downloaded before to the IDE optical drive

Once you've booted the three servers they should be reachable from the provisioner server via ssh

* `demo@192.168.1.101`
* `demo@192.168.1.102`
* `demo@192.168.1.103`

as public key file for user `demo` has been copied to them

You can check that etcd cluster has been properly set using:

```
demo@master-2 ~ $ etcdctl cluster-health
member 2e1f832bcb427731 is healthy: got healthy result from http://master-2.infra.local:2379
member 369cd276628e761c is healthy: got healthy result from http://master-3.infra.local:2379
member a4f498f36b5331a7 is healthy: got healthy result from http://master-1.infra.local:2379
cluster is healthy
```

## Terraform files notes

Matchbox and Ignitions are Terraform logical providers. They don't create the resources but provide configuration for it. Matchbox provider uses the gRPC endpoint to push the files needed to the server.

Main terraform files are located in [environment](./terraform/environment) directory. They describe the configuration of the three servers using the [server/master](terraform/modules/server/master) module. There are two main files there:

* [Matchbox configuration](terraform/modules/server/master/matchbox.tf) that defines how the group and profile file are built.
* [Ignition configuration](terraform/modules/server/master/ignition.tf) that defines how the ignition JSON file is built. It uses the [raw_ignition](https://github.com/coreos/terraform-provider-matchbox/blob/0984179ff5c61eb0ab8262855811214c6c0bad54/matchbox/resource_profile.go#L53) property to pass a rendered JSON to matchbox instead of a Container Linux Config that would get transpiled to JSON by Matchbox server. In order to make a full example with reusable components, Ignition config is provided as the output of different [ignition](terraform/modules/ignition) modules corresponding to the different systemd, netword, etc units
