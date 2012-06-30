--- 
tags: []

date: 2008-01-12 22:44:21 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/gutsy-realtek-hd-audio-and-the-toshiba-u300/
author: maxmanders
wordpress_id: 81
published: true
layout: post
categories: 
- Linux
title: Gutsy, Realtek HD Audio and the Toshiba U300
comments: []

author_email: max@maxmanders.co.uk
---
This post is really an aide-memoire for me should I need to rebuild my laptop in the future, but it may prove useful to others.  My Toshiba U300 laptop seems to have problems with Realtek HD Audio.  After some searching and trial-and-error, I found that the following gets things working.

<pre>
sudo apt-get install linux-backports-modules-generic
</pre>
