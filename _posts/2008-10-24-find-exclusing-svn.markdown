--- 
tags: []

date: 2008-10-24 16:13:34 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=101
author: maxmanders
wordpress_id: 101
published: true
layout: post
categories: 
- Development
- Linux
title: Find Excluding SVN
comments: []

author_email: max@maxmanders.co.uk
---
So, you need to take a copy of a subversion working copy, but it has local changes that you also need to copy.&nbsp; This precludes the use of `svn export` since the local changes won't be included.&nbsp; One option is to do an `svn export` anyway, and then `cp -ra` the local changes.&nbsp; Another solution is to use a find command that excludes subversion metadata, and then copy the resulting files:

`find . -path '*/.svn' -prune -o -type f -print`

I did something similar some time ago, but forgot the command, so here it is for posterity.
