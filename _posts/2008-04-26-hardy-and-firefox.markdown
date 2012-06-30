--- 
tags: []

date: 2008-04-26 18:06:26 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=94
author: maxmanders
wordpress_id: 94
published: true
layout: post
categories: 
- Web Development
- Linux
title: Hardy and Firefox
comments: []

author_email: max@maxmanders.co.uk
---
As I mentioned in my last post, I have had issues getting Firebug working in Firefox 3.0b5.&nbsp; Unfortunately at the moment Firebug isn't compatible with the beta release of Firefox 3.&nbsp; To be honest, I'm quite happy with Firefox 2.x.&nbsp; From what I've read, Firefox 3 is more stable and less memory-hungry that its predecessor, and it does look nice (especially so according to Mac users).&nbsp; Unfortunately, these benefits are outweighed by my love of the Firebug extension.&nbsp; It is, in my opinion, the best debug tool for web developers bar none.&nbsp; To that end, I've chosen to remove Firefox 3 (and all the bits and bobs that come with it) and install Firefox 2.

A few apt-gets later, I had got rid of Firefox-3 and related packages, and installed Firefox-2, symlinked to /usr/bin/firefox.&nbsp; However, Firefox-2 still used the profile created by Firefox-3 in my home directory.&nbsp; I started Firefox from the terminal, with the '-ProfileManager' switch.&nbsp; I created a new profile, renamed default, and renamed my new profile to default.&nbsp; I then copied my bookmarks and related data from the old profile directory to the new one.&nbsp; Once this was done, I started Firefox with my new default profile,&nbsp; installed my favourite plugins and all was good - Firebug now works like a dream!
