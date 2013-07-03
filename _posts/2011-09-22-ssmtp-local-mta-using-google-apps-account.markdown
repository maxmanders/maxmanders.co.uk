--- 
tags: []

date: 2011-09-22 10:05:38 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=411
author: maxmanders
wordpress_id: 411
published: true
layout: post
categories: 
- Articles
- Linux
title: SSMTP Local MTA Using Google Apps Account
comments: []

author_email: max@maxmanders.co.uk
---
While there are plenty of MTAs out there, I find it quite handy to have SSMTP installed locally; it's quick to install and configure and lacks some of the overhead of a more <em>enterprise</em>&nbsp;MTA such as Sendmail, Postfix, Exim etc. &nbsp;The following assumes you have a "Google Apps for Domains" user account -- ssmtp_user@domain.com -- through which you will relay all email. &nbsp;Additionally, the steps below work on Ubuntu 10.10, similar steps should work on other distributions.

<strong>Install SSMTP</strong>

      sudo apt-get install ssmtp


<strong>Edit configuration in /etc/ssmtp/ssmtp.conf</strong>

      # Backup the original first
      sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.out
      # Truncate the file and add the following
      mailhub=smtp.gmail.com:587
      hostname=ssmtp_user@domain.com
      root=ssmtp_user@domain.com
      AuthUser=ssmtp_user@domain.com
      AuthPass=<ssmtp_user_password>
      UseSTARTTLS=yes
      UseTLS=yes
      FromLineOverride=yes



<strong>Edit revaliases map in /etc/ssmtp/revaliases.conf</strong>

      # Add a line for each local user who should be able to send email
      root:smtp_user@domain.com:smtp.gmail.com:587
      max:smtp_user@domain.com:smtp.gmail.com:587

<strong>Send Email!</strong>
You should now be able to send email, e.g. from the shell using

      echo "Testing" | mail -s "Test Email" someone@example.com
