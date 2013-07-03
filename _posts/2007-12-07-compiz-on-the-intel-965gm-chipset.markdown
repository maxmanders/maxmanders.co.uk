--- 
tags: []

date: 2007-12-07 21:31:25 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/compiz-on-the-intel-965gm-chipset/
author: maxmanders
wordpress_id: 75
published: true
layout: post
categories: 
- Linux
title: Compiz on the Intel 965GM Chipset
comments: []

author_email: max@maxmanders.co.uk
---
I recently tried to get compiz working on my laptop; a Toshiba u300 running Ubuntu 7.10 "Gutsy Gibbon".  The Toshiba U300 uses the Intel 965GM chipset which doesn't seem to be compatible with compiz.  After some digging I discovered a repository that contains a modified xorg-xserver-video-intel package.  This combined with the 915resolution package allowed me ues the native 1280 * 800 resolution, and enable compiz desktop effects.

    # as root / sudo
    echo "deb http://ppa.launchpad.net/kyle/ubuntu gutsy main" >> /etc/apt/sources.list"
    apt-get update
    apt-get upgrade
    apt-get install xserver-xorg-video-intel
    dpkg-reconfigure xserver-xorg

One reboot later and all was well.
