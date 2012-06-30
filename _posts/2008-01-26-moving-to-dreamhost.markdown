--- 
tags: []

date: 2008-01-26 14:42:56 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/web-development/moving-to-dreamhost/
author: maxmanders
wordpress_id: 84
published: true
layout: post
categories: 
- Web Development
title: Moving To Dreamhost
comments: []

author_email: max@maxmanders.co.uk
---
After some months of being unhappy with the service from Hostgator, I decided yesterday to move to Dreamhost.&nbsp; While Hostgator are very affordable and for the most part reliable, the ssh connection was always painfully slow; it took me considerable effort in the beginning to even get ssh access (having been required to justify my need to them); the control panel they provided (cPanel) made it difficult to get anything done; and as far as I know I could only host a single site with them.

After a recommendation from a colleague at work, I decided to switch to Dreamhost.&nbsp; I opted to pay for a year in advance, as the monthly direct-debit payments are a little more expensive otherwise, and there is an initial setup fee if you pay monthly.&nbsp; The control panel is far more intuitive and a lot easier to use.&nbsp; I can host as many sites and sub-domains as I like with as many users, email accounts and MySQL databases as I like.&nbsp; Once I had created the account and switched my name servers with my domain registrar everything was underway.&nbsp; Within half an hour I had shell access, an initial account with which I could create more accounts, an initial email address of my choosing (thus reducing email outage to a minimum) and a general impression that Dreamhost were a lot more professional and experienced.

Obviously it will take up to 48 hours for the new name server settings to propagate to the root name servers, but despite this within about four hours the name server change had been effective for me.&nbsp; After about 15 minutes work making changes to my local copy of my Wordpress installation and MySQL dump, I rsync-ed everything to the new server, got the database up and running, and job done!
