--- 
tags: []

date: 2008-01-18 19:41:44 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/ssh-tunnelling/
author: maxmanders
wordpress_id: 82
published: true
layout: post
categories: 
- Development
- Linux
title: SSH Tunneling
comments: []

author_email: max@maxmanders.co.uk
---
Another aide memoire, but again may be useful to some.  I'd like the ability to work from home on some web development projects I'm doing at work.  Getting the code locally is not a problem thanks to Subversion over ssh  However viewing the results can be tricky when you consider that the development server is behind the work network.  The answer is SSH tunneling.

Let's say you can access SERVER_A directly over ssh  The service you want to access is on SERVER_B which you can't access directly via SSH from your local machine.  However, you can access SERVER_B from SERVER_A.  I'll assume that you want to access the service locally on port 12345, and that the remove port is port 80.  The following command will allow you to access a service on SERVER_B from your local machine.

<code>ssh -Nf -L 12345:SERVER_B:80 username@SERVER_A</code>

The '-Nf' switch says don't execute a command with this ssh session, and run this ssh process in the background.  The first port is the port you want to use locally; the first server is the usually inaccessible remote server you want access to; and the third port is the remote port you want to use.  The final argument gives the login to the remotely accessible server you have ssh access to directly.

One caveat to this is if you are trying to access a web site that is defined using Apache virtual hosts.  With this command alone, requesting localhost:12345 in Firefox would only direct you to the site that is listening remotely for requests that match 'localhost'.  If you would ordinarily access this site using mysite.server_b, then you need to use that as the address in Firefox on your local machine.  Therefore, this needs to be added in /etc/hosts.  With that done, you should be able to request mysite.server_b:12345 in Firefox and be directed to the remote "virtual host" site.
