--- 
tags: []

date: 2007-12-07 21:36:05 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/compiz-and-video-playback-problems/
author: maxmanders
wordpress_id: 76
published: true
layout: post
categories: 
- Linux
title: Compiz and Video Playback Problems
comments: []

author_email: max@maxmanders.co.uk
---
There seem to be a number of bugs related to video playback while compiz desktop effects are enabled, specifically on systems using the Intel 965GM chipset.&Acirc;&nbsp; If desktop effects are enabled, any attempts to play video files result in the player closing.

This problem can be resolved by setting the output module for your player of choice to X11.&Acirc;&nbsp; In VLC, goto Settings->Preferences->Video->Output Modules.&Acirc;&nbsp; Check the "Advanced Options" box.&Acirc;&nbsp; Select "X11 video output" from the drop down box and save the changes.
