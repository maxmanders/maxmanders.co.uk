--- 
tags: []

date: 2007-05-19 23:54:06 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/technology/hosting-with-hostgator/
author: maxmanders
wordpress_id: 46
published: true
layout: post
categories: 
- Technology
- Web Development
title: Hosting With Hostgator
comments: 
- date: Tue May 22 15:12:46 +0100 2007
  date_gmt: Tue May 22 15:12:46 +0100 2007
  author_url: ""
  author: Phil
  content: Wow, thought we'd lost you there.  Took me a few days to realise you'd just moved.
  author_email: phil_nw@yahoo.com
  id: 1229
excerpt: "Up until recently my hosting was provided by Fasthosts.  For reasons that have nothing to do with the experience I have had with Fasthosts I have had to move to an alternative hosting provider.  After some research I opted to go with Hostgator's Baby plan. The features included with this hosting plan are excellent for the small fee of &Acirc;&pound;5.00 per month.   And the technical support is brilliant.  I initially had problems getting SSH access, but after raising the issue via the ticket system, I had SSH access within a few emails! "
author_email: max@maxmanders.co.uk
---
Up until recently my hosting was provided by Fasthosts.  For reasons that have nothing to do with the experience I have had with Fasthosts I have had to move to an alternative hosting provider.  After some research I opted to go with Hostgator's Baby plan. The features included with this hosting plan are excellent for the small fee of &Acirc;&pound;5.00 per month.   And the technical support is brilliant.  I initially had problems getting SSH access, but after raising the issue via the ticket system, I had SSH access within a few emails! <!--more-->

Once I was certain I had everything I needed from the hosting, I changed the domain name servers and within a day or two my domain name was pointing to the Hostgator server and my MX records were altered accordingly.  The next step - migrating Wordpress!

This is the first time I have migrated content between hosts, and I was reasonably confident I could manage it.  Hostgator did offer a migration service but I thought it would be beneficial to have a shot myself.  I have come to expect reliability and robustness from Wordpress, and this migration was no exception - almost.  I migrated the database between servers without any problems; a simple enough task with the help of PHPMyAdmin.  Next I downloaded my wordpress directory from Fasthosts and uploaded it to Hostgator.  The configuration was changed with Vi, and all was almost well.

Unfortunately Wordpress stores the records that represent files (uploads, images etc.) as absolute filesystem paths rather than relative URLs.  As such my uploaded images and other files, despite being on the new server, failed to load in the browser.  I had to manually alter all of the records in the database that referred to filesystem paths so that my uploads were correctly referenced by Wordpress.  I'm sure there must be a patch or plugin to do this, but at the time I couldn't find one.

I think now that I have done this migration without too much difficulty I'll export my database again, and do a clean install of the latest version of Wordpress.  Given that we are now in summer, although the ever changing Scottish weather would have you believe otherwise, my autumnal theme should be updated to a give a more summery feel.  So that's my next project, a redesigned 'Max says...'!
