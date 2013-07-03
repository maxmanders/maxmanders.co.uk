--- 
tags: []

date: 2008-06-29 17:27:23 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=98
author: maxmanders
wordpress_id: 98
published: true
layout: post
categories: 
- Linux
title: "Samba: Linux to Linux Gotcha"
comments: []

author_email: max@maxmanders.co.uk
---
It's been a long time coming, but I've finally got my machine at work set up using Ubuntu 8.04 rather than Windows XP.&nbsp; I've been using Ubuntu at home almost exclusively for nearly a year now, so it's good to be able to maintain my workflow from home to work.&nbsp; One of the problems I had was mounting&nbsp; my home directory on a server.

On windows, this works fine: you specify a username, a password, and the share you want to connect to and it just works.&nbsp; The same is almost true with linux: you specify the username, password and share (either on the command line or in /etc/fstab).&nbsp; However, chances are your local UID will differ from the UID used on the server, so although the mount will succeed, permissions may be a bit iffy.

The solution was to use CIFS rather than the outdate smbfs, and to use the extra uid option:

    $ sudo mount -t cifs -o username=user,password=pass,uid=1000 //server/share /local/mount/point

This makes sure that the share you mount is owned by the local user.
