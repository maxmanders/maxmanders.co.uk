--- 
tags: []

date: 2009-02-28 21:14:47 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=106
author: maxmanders
wordpress_id: 106
published: true
layout: post
categories: 
- Linux
title: Continue in Interactive Bash Loop
comments: []

author_email: max@maxmanders.co.uk
---
Came across a useful keyboard shortcut to continue to the next iteration of an interactive bash for loop.&nbsp; Let's say you have something like:
      for i in $(cat server_list.txt); do
         ssh -q $i hostname
      done

If one of the servers is unresponsive, you can continue to the next iteration with<br />

      ctrl + \
