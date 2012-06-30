--- 
tags: []

date: 2010-10-04 21:05:13 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=265
author: maxmanders
wordpress_id: 265
published: true
layout: post
categories: 
- Development
- Linux
title: Subversion And The Entropy Pool
comments: []

author_email: max@maxmanders.co.uk
---
I ran into an interesting little subversion problem earlier.&nbsp; I was trying to commit a change, and the commit just seemed to hang indefinitely.&nbsp; I couldn't sent an interrupt, and eventually resorted to killing the process.&nbsp; I tried all sorts of command line options in case there was an authentication problem - with no luck.&nbsp; I then thought I had made a mistake when switching my working copy to a different branch.&nbsp; I checked the logs on the server to find nothing pertinent; it seemed as though svn didn't get as far as taking to the server.&nbsp; At a loss, I thought there was nothing for it but to run the command with strace.&nbsp; Bingo!

Strace showed that subversion reads from /dev/random as part of the commit, and that's where the problem seemed to be happening.&nbsp; After doing some research, I discovered that /dev/random generates random numbers using the so-called <em>entropy pool</em>.&nbsp; This <em>entropy pool</em> is just random bits of noise generated from things such as mouse movements, time between keystrokes and so on.&nbsp; For whatever reason, on the client server, this <em>entropy pool</em> was empty!&nbsp; Using /dev/random is cryptographically <em>more random</em> than using /dev/urandom; and /dev/random blocks when the <em>entropy pool</em> is empty, whereas /dev/urandom is non-blocking.&nbsp; Moving /dev/random to /dev/random.old and linking /dev/urandom to /dev/random solved the problem.&nbsp; There may be a better solution to this, and depending on your cryptographic requirements it might be better to find an alternative, but this did the trick for me.&nbsp; One svn commit later and all was well.
