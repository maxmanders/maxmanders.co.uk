--- 
tags: []

date: 2011-03-06 22:55:05 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=306
author: maxmanders
wordpress_id: 306
published: true
layout: post
categories: 
- Development
- Linux
title: Automating Internet Explorer VPC Images On VirtualBox
comments: 
- date: Wed Mar 09 12:38:53 +0000 2011
  date_gmt: Wed Mar 09 11:38:53 +0000 2011
  author_url: http://eggfriedrice.com
  author: Al
  content: Awesome! I'll have a crack at using your script at some point, looks like it'll be handy.
  author_email: al@plasticfish.co.uk
  id: 17428
- date: Wed Mar 09 13:08:24 +0000 2011
  date_gmt: Wed Mar 09 12:08:24 +0000 2011
  author_url: http://maxmanders.co.uk
  author: maxmanders
  content: Definitely still a work in progress, a few more 'tweaks' but hopefully it will be useful to other people!
  author_email: max@maxmanders.co.uk
  id: 17430
- date: Tue Apr 05 04:39:16 +0100 2011
  date_gmt: Tue Apr 05 03:39:16 +0100 2011
  author_url: ""
  author: Trace
  content: Spiffy. Can't wait to try it, and I'll look forward to any continued developments :-)
  author_email: NatePMartin@Gmail.com
  id: 17964
author_email: max@maxmanders.co.uk
---
In order to facilitate testing of websites in different browsers, Microsoft have released what they call their '<a title="Microsoft Application Compatibility VPC Images" href="http://www.microsoft.com/downloads/en/details.aspx?FamilyID=21eabb90-958f-4b64-b5f1-73d0a413c8ef&amp;displaylang=en" target="_blank">Application Compatibility Virtual PC Images</a>'. &nbsp;These time-limited <a title="Virtualization (V12n)" href="en.wikipedia.org/wiki/Virtualization" target="_blank">V12n</a> solutions are great for quickly bringing up a VM for a particular version of Internet Explorer but they are built for Microsoft's Virtual PC (VPC) software.

I work&nbsp;predominantly&nbsp;with Linux and use <a title="Virtual Box" href="http://www.virtualbox.org" target="_blank">Virtual Box</a> as my V12n application of choice. &nbsp;Later versions of Virtual Box support VPC's VHD disk image format. &nbsp;This means it's possible to run these VPC images under VirtualBox, but it involves downloading and extracting files from the win32 executables; downloading drivers for the ethernet adapter and other time consuming steps that I'd rather not repeat every time my IE VM expires. &nbsp;I'm a programmer, therefore I'm lazy and don't like doing things more than once; I'd rather script something to do it for me. &nbsp;In keeping with this virtue, I've written <a title="msie2vbox" href="http://maxmanders.co.uk/msie2vbox">msie2vbox</a> to automate this stuff for me. &nbsp;It's on <a title="msie2vbox on Github" href="https://github.com/maxmanders/msie2vbox/" target="_blank">Github</a> with a GPLv3 license. &nbsp;There's some outstanding todo items but it does the job for me, and I thought it might be of use to others.
