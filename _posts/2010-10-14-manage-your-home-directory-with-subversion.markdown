--- 
tags: []

date: 2010-10-14 22:16:28 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=275
author: maxmanders
wordpress_id: 275
published: true
layout: post
categories: 
- Development
- Linux
title: Manage Your Home Directory With Subversion
comments: []

excerpt: Revision control systems serve their purpose well for managing codebases, but they can also be used to good effect for configuration management.&nbsp; I'll discuss how I've used Subversion to manage the configuration of my home directory.&nbsp; The same goal could probably be achieved just as easily with Git.&nbsp; While I use Git and Github for personal projects, I have employed this solution at work where we use Subversion.
author_email: max@maxmanders.co.uk
---
Revision control systems serve their purpose well for managing codebases, but they can also be used to good effect for configuration management.&nbsp; I'll discuss how I've used Subversion to manage the configuration of my home directory.&nbsp; The same goal could probably be achieved just as easily with Git.&nbsp; While I use Git and Github for personal projects, I have employed this solution at work where we use Subversion.<!--more-->

I'm often jumping on and off of a number of different servers where I use a variety of programs such as Gnu Screen and Vim.&nbsp; If I tweak <em>~/.vimrc</em> for example, I have to remember to copy the changed file to all of the other servers I use, which is a pain.&nbsp; I could request that home directories be auto-mounted using autofs, but this solution is something I can implement myself in isolation without effecting any other users.&nbsp; The idea is to store configuration files in SVN so that when I make a change on one server, I can push that change to SVN and pull the change down to any other server I happen to be on.&nbsp; The approach I'm taking here is to have a local working copy in my home directory, and to have configuration files symlinked into that working copy.&nbsp; This could be made more flexible by having different configurations stored in a separate branch and switching branches depending on your needs.

I'm sure there are better ways to do this, such as having the entire home directory in subversion, and automatically updated on login.&nbsp; Perhaps you could use SVN externals to provide a modular approach to managing your configuration.&nbsp; The great thing about SVN, and more generally Linux is that there are plenty of different ways to achieve your goal.

Before I go on, I've made a few assumptions based on my server configuration - Ubuntu 10.04 with Apache 2.2.14 and Subversion already installed.&nbsp; The first thing we need to do is enable SVN over HTTP.

      sudo apt-get install libapache2-svn

Once installed, we need to configure the module in <em>/etc/apache2/mods-enabled/dav_svn.conf
</em>

      DAV svn
      SVNParentPath /var/lib/svn
      AuthType Basic
      AuthName "Subversion Repository"
      AuthUserFile /etc/apache2/dav_svn.passwd
      Require valid-user

This configuration will allow you to refer to your repositories via e.g. http://example.com/svn, where the actual location of your repositories on the filesystem is <em>/var/lib/svn</em>.&nbsp; We're also using basic authentication here, so we'll need to add a valid user.

      sudo htpasswd -c /etc/apache2/dav_svn.passwd username

Next, we need to create our SVN directory and create a first repository

      sudo mkdir -p /var/lib/svn
      sudo svnadmin create /var/lib/svn/homedir
      sudo chown -R :www-data /var/lib/svn
      sudo chmod 700 /var/lib/svn
      sudo chmod -R 755 /var/lib/svn/homedir
      

Now, on a server that has a good baseline set of configuration files, we can check out a working copy

      svn co http://example.com/svn/homedir .

Add some configuration files

      cp ~/.bashrc ~/.vimrc ~/.vimrc ~/homedir
      cd ~/homedir
      svn st | awk '/\?/ {print $2}' | xargs svn add
      svn commit -m "Initial Commit"

We can now symlink our files to those in the working copy

      ln -sf ~/homedir/.bashrc ~/.bashrc
      ln -sf ~/homedir/.vimrc ~/.vimrc
      ln -sf ~/homedir/.screenrc ~/.screenrc

If we do this on all the servers we use, we can make a change in one place, commit it to SVN, and then update our working copy somewhere else to get the most up-to-date version of the files.&nbsp; As I said before, I'm sure this can be enhanced and tweaked to be more efficient, but this serves my needs for now.
