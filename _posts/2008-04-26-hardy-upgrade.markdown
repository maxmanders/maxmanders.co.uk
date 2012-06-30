--- 
tags: []

date: 2008-04-26 16:22:37 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=93
author: maxmanders
wordpress_id: 93
published: true
layout: post
categories: 
- Linux
title: Hardy Upgrade
comments: []

author_email: max@maxmanders.co.uk
---
The latest stable release of Ubuntu linux (Hardy Heron) was released this week, and having eagerly awaited its release I decided to upgrade my desktop and laptop from Ubuntu 7.10 to 8.04.&nbsp; I'm going to keep my server on 7.10 for the time being however.

The upgrade went surprisingly smoothly.&nbsp; It was just a matter of 'sudo apt-get update', 'sudo apt-get upgrade' and 'sudo apt-get dist-upgrade'.&nbsp; After an hour or so, the installation was complete and I rebooted.

I had a few issues with both my laptop and desktop, but these were resolved fairly easily.&nbsp; The Realtek sound on my laptop was supported via linux-backports-modules-generic.&nbsp; This didn't seem to be available in Hardy, and neither the old ALSA, nor the new Pulse Audio Server seemed to support my Realtek onboard audio.&nbsp; A bit of searching on the Realtek website revealed linux drivers, which I promptly downloaded, unzipped and installed.&nbsp; Success!

When my desktop came back up after the reboot, the keyboard seemed to have a delay of a number of seconds, and would intermittently behave as if a key had held down.&nbsp; Also, Gnome didn't come up properly, with the desktop being black.&nbsp; I rebooted again and everthing seemed fine... for now.

Firefox 3.0b5 comed preinstalled with Hardy.&nbsp; Unfortunately, the brilliant Firebug web developer extension isn't compatible with this version of Firefox.&nbsp; I hope that the final release of Firefox will fix this compatibility issue.&nbsp; For the time being, I will have to install Firefox 2.x to allow me to use Firebug.

In summary, I'm very impressed with how easy and smoothly the upgrade went.&nbsp; Aside from a few small issues everything worked fine after the upgrade, it's just a shame about including a prerelease web browser in a LTS release of Ubuntu.&nbsp; Perhaps they should have stuck with Firefox 2.x until Mozilla officially released version 3 of their excellent browser.
