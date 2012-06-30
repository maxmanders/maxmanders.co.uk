--- 
tags: []

date: 2007-09-23 21:34:35 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/taming-the-fedora-beast/
author: maxmanders
wordpress_id: 65
published: true
layout: post
categories: 
- Linux
title: Taming The Fedora Beast
comments: []

author_email: max@maxmanders.co.uk
---
As some of you might be aware, I have rencetly been having some problems with my web/development server.  It's a Fedora 7 machine with a LAMP install, Java 5 and a few other odds and ends, and although I appreciate that Fedora tends to be an experiment vehicle on which Redhat tests new bits-and-bobs I was a little put off when I discovered problems with my network after updating the kernel to 2.6.22.4.

Essentially, everything seemed to be working okay, but for some reason I couldn't ping any other computer on the network from the web server; nor could I ping the web server from any other machine on the network.  The eth0 interface was up; I could ping localhost, and the static IP address I'd assigned the NIC; the Ethernet cable was good (I tried two cables, both of which I was certain were good).  However, the LED on the hub was constantly on for the web server connection, and 'ethtool etho' indicated that there was no link.

After several days of trying to fix the problem, I tried building an older kernel to use.  It was the first time I had tried this, and it all went well - however, this did not fix the problem.  It would seem that my initial assessment that the kernel update was causing the problems was incorrect.

Then I came up with the solution.  Prior to the problems, I had been using the onboard NIC, a SiS900 based interface.  I disabled the onboard, and put in a PCI SiS900 based NIC.  This solved the problem and all was well.  I still can't think what the problem was - and don't have the expertise to go through the logs and reverse the updates.  For some reason - beyond my ken - updating the system interfered with the onboard NIC, but a PCI NIC with the same chipset worked fine.  It wasn't the kernel because I reverted that to the version prior to the update.

All's well that ends well as they say... I now have my web server up and running.  Well, almost.  I used to do a lot of coding and administration using FreeNX over SSH to get a desktop.  FreeNX has now stopped working!  I've won the battle, but still the war goes on!
