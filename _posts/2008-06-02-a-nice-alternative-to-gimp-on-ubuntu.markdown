--- 
tags: []

date: 2008-06-02 21:38:56 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=95
author: maxmanders
wordpress_id: 95
published: true
layout: post
categories: 
- Linux
title: A nice alternative to GIMP on Ubuntu
comments: []

author_email: max@maxmanders.co.uk
---
I'm not one of the many ardent Microsoft haters that use Linux, and as such I'm quite open to taking full advantage of whatever software I can to get the job done, whether I'm in Linux or Windows.  I really quite like Paint.Net which I've used on Windows as an alternative to Photoshop and the GIMP.  You can now get Paint.Net on Linux courtesy of the Mono framework:

    $ sudo apt-get install mono-common libmono* mono-gmcs
    $ svn co http://paint-mono.googlecode.com/svn/trunk/src paint-mono
    $ cd paint-mono
    $ ./configure
    $ make
    $ make install
    $ paintdotnet

I've been informed by someone commenting on this post that the above doesn't appear to work any more, the below is command line output of a successful install, hope it helps.

    $ cd /tmp
    $ wget http://paint-mono.googlecode.com
       /files/paintdotnet-0.1.63.tar.gz
    $ tar xvfz paintdotnet-0.1.63.tar.gz
    $ ./configure
    Looking for required packages
    Checking for revision&hellip;
    paintdotnet has been configured with
    prefix = /usr/local
    config = RELEASE_AND_PACKAGE_ANY_CPU
    $ make
    $ sudo make install
    &hellip;
    make post-install-local-hook prefix=/usr/local
    &hellip;
    $ cd /usr/local/bin
    $ ls -ltr | tail -n1
    paintdotnet
    $ ./paintdotnet
