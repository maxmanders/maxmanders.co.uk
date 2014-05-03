---
layout: post
title: "AWS VPN Solutions with StrongSWAN"
date: 2014-05-01 15:35:03 +0100
published: true
author: Max Manders
tags:
- aws
- networking
- ipsec
- vpn
- strongswan
- linux
categories:
- aws
---
#### Overview
In this article, I'll discuss how to connect two or more VPCs which are in different AWS
regions.  Unless you use BGP to advertise routes, you will need to peer every region with
every other region to provide full connectivity between multiple regions.  Using static
routing, routes cannot be re-advertised and as such it will not be possible to write
routing tables that allow a packet to traverse from one VPC to another via an intermediary
VPC, where all VPCs are connected by IPSec tunnels.  Using and configuring BGP is outside
of the scope of this article.
<!--more-->

#### Introduction
Connecting AWS VPCs across regions is not currently supported using the recently released
VPC Peering feature.  VPC Peering only allows you to connect VPCs within the _same_
region.  If you want to securely connect VPCs across regions, you have two options

* run a software based IPSec solution on an instance in each region, connect the two
  instances, and use appropriate routing tables in each VPC to use the tunnel
* run an AWS VPN in one VPC and connect it to a software based IPSec solution on an
  instance in another region, again using appropriate routing tables in each VPC to use
  the tunnel

The two most popular software based IPSec solutions for Linux seem to be OpenSWAN and its
fork StrongSWAN.  I've opted for StrongSWAN on the basis of what I believe to be better
documentation, and the fact that it is still under active development.  I did find at the
time however that the version of StrongSWAN available from the Ubuntu repositories (v4.5)
didn't play nicely with AWS VPNs.  Thankfully, Ubuntu 14.04 now support StrongSWAN v5.1,
but I ended up using a package form a Debian backports repository. 

#### Assumptions
This article assumes a certain familiarity with AWS.  Specifically I assume that you are
able to:
* create a VPC and public and private subnets
* create a routing table to route public traffic for your public subnets via an Internet Gateway
* create a routing table to route public traffic for your private subnets via a public NAT
  instance
* create a public NAT instance
* create and edit security groups


#### Scenario 1: Connect VPC_1 with VPC_2 using StrongSWAN and AWS VPN
{% lightbox diagram vpn-scenario-1.png caption:"Scenario 1" alt="Scenario 1" %}

##### Step 1: Configure a StrongSWAN server
1. Launch a new `m1.small` instance in a public subnet of your VPC
  * Choose an Ubuntu 14.04 x86_64 AMI
  * For now, ensure that your Security Groups are configured to permit SSH from your local
    workstation.  _We'll need to reconfigure them later once both endpoints have been
    created_.
  * Attach a new EIP to the instance
2. Install StrongSWAN and its dependencies
  * `sudo apt-get install strongswan*`

##### Step 2: Create AWS VPN in VPC_2
For this discussion, we shall assume that VPC_2 is located in _eu-west-1_ and has a
network block of `172.60.0.0/16`.

1. Navigate to the VPC Dashboard in the AWS Console
2. Make sure you are in the correct region
3. Select the 'Virtual Private Gateways' menu item
4. Click 'Create Virtual Private Gateway'
  * Give your new VGW an appropriate name
5. Select 'Yes, Create'
6. Once your VGW has been created, select it, and then click 'Attach to VPC'
  * Select the target VPC from the VPC drop-down list
7. Select the 'Customer Gateways' menu item
8. Click 'Create Customer Gateway'
  * Give your CGW an appropriate name
  * Set routing to _Static_
  * Set the public IP address of the remote end of the VPN connection, i.e. the EIP of the
    StrongSWAN instance.
9. Click 'Yes, Create'
10. Select the 'VPN Connections' menu item
11. Click 'Create VPN Connection'
  * Name: Give your VPN connection an appropriate name
  * Virtual Private Gateway:  Select the VGW you created in step 4
  * Customer Gateway: Select 'Existing' and choose the CGW you created in step 8
  * Routing Options: Static
  * Static IP Prefixes: Set the CIDR block of your VPC you wish to make available over the
    VPN tunnel, e.g. 172.60.0.0/16 for the entire VPC network
12. Click 'Yes, Create'

#### Step 3: Update StrongSWAN Security Groups
Now that we have both ends of the tunnel configured, we need to ensure that they can talk
to each other.

#### Step 4: Configure Routing
We now need to ensure 

#### Secnario 2: Connect VPC_1 with VPC_2 using StrongSWAN
{% lightbox diagram vpn-scenario-2.png caption:"Scenario 2" alt="Scenario 2" %}

#### Secnario 3: Connect VPC_1, VPC_2 and VPC_3 using StrongSWAN and AWS VPN
{% lightbox diagram vpn-scenario-3.png caption:"Scenario 3" alt="Scenario 3" %}
