--- 
tags: []

date: 2010-04-30 18:32:08 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=174
author: maxmanders
wordpress_id: 174
published: true
layout: post
categories: 
- Web Development
- Linux
- PHP
title: Revert to PHP 5.2 in Ubuntu 10.04 (Lucid Lynx)
comments: 
- date: Tue Sep 07 18:45:35 +0100 2010
  date_gmt: Tue Sep 07 17:45:35 +0100 2010
  author_url: http://www.welcome2inter.net
  author: Welcome 2 Inter.Net
  content: |-
    Thanks for this nice howto.
    
    I think an
    
    apt-get update
    
    is missing in this howto.
  author_email: info@welcome2inter.net
  id: 13471
- date: Wed Sep 08 23:47:14 +0100 2010
  date_gmt: Wed Sep 08 22:47:14 +0100 2010
  author_url: http://maxmanders.co.uk
  author: maxmanders
  content: Well spotted!  I've updated the post to include the necessary 'apt-get update'.
  author_email: max@maxmanders.co.uk
  id: 13495
- date: Mon Oct 04 15:04:48 +0100 2010
  date_gmt: Mon Oct 04 14:04:48 +0100 2010
  author_url: ""
  author: hasan
  content: Great it seams it working fine ... let see finally how it goes. this help seams very nit.
  author_email: md.hasanur@gmail.com
  id: 13986
author_email: max@maxmanders.co.uk
---
Despite suppressing updates of my LAMP stack, the upgrade to Ubuntu 10.04 ignored that, and as such I now have PHP 5.3.X installed.&nbsp; Ordinarilly this woud be fine, but one of the open source web applications I work with doesn't play well with PHP 5.3.X.&nbsp; I needed a simple way to revert to a previous 5.2.X version of PHP.&nbsp; The version in the Ubuntu 9.10 (Karmic) repositories would do the trick, so it was jsut a case of forcing Ubuntu to honour the 9.10 versions of various PHP packages over the 10.04 versions.

First, we get a list of all the currently installed PHP packages:

      sudo dpkg -l | grep php > /tmp/php.packages

Next we remove the currently installed PHP packages:

      sudo apt-get remove --purge $(dpkg -l | grep php)

Now we need to create an alternative sources list:

      sed s/lucid/karmic/g /etc/apt/sources.list |\
      sudo tee /etc/apt/sources.list.d/karmic.list

Having done that, we need to generate an aptitude preferences file for PHP:

      awk '{print "Package: " $0; print "Pin: release a=karmic\nPin-Priority: 991\n"}' /tmp/php.packages |\
      sudo tee /etc/apt/preferences.d/php

This preferences file tells aptitude that for each listed package, we want to pin down the installation candidate to that from the Karmic repositories.  We can now install the packages that we previously removed, but this time the versions from the Karmic repositories:

      sudo apt-get update && apt-get install $(cat /tmp/php.packages | tr "\n" " ")

A quick restart of Apache and everything seems to be working with the older version of PHP!
