---
layout: post
title: "AWS VPN Solutions with StrongSWAN"
date: 2014-05-01 15:35:03 +0100
published: false
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
didn't play nicely with AWS VPNs.  Thanksfully, Ubuntu 14.04 now support StrongSWAN v5.1,
but I ended up using a package form a Debian backports repository.

#### Scenario 1: Connect VPC_1 with VPC_2 using StrongSWAN and AWS VPN
{% img class /images/vpn-scenario-1.png 700px 'Scenario 1' 'Scenario 1' %}

#### Secnario 2: Connect VPC_1 with VPC_2 using StrongSWAN
{% img class /images/vpn-scenario-2.png 700px 'Scenario 2' 'Scenario 2' %}

#### Secnario 3: Connect VPC_1, VPC_2 and VPC_3 using StrongSWAN and AWS VPN
