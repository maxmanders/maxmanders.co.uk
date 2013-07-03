--- 
tags: []

date: 2007-08-15 20:12:03 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/general/symfony-woes/
author: maxmanders
wordpress_id: 52
published: true
layout: post
categories: 
- Development
title: Symfony Woes
comments: 
- date: Wed Aug 15 21:13:00 +0100 2007
  date_gmt: Wed Aug 15 21:13:00 +0100 2007
  author_url: http://maxmanders.co.uk
  author: max
  content: Cracked it! I had a '-' instead of an '_' in my Directory directive of the VirtualHost section in httpd.conf.  Oh well, too much coding for one day!
  author_email: max@maxmanders.co.uk
  id: 1309
- date: Wed Aug 15 22:37:05 +0100 2007
  date_gmt: Wed Aug 15 22:37:05 +0100 2007
  author_url: http://cakephp.org/
  author: Nate
  content: Heh, there's a reason we get so many people switching to Cake from Symfony... several actually. ;-)
  author_email: nate@cakephp.org
  id: 1310
- date: Wed Aug 15 22:41:37 +0100 2007
  date_gmt: Wed Aug 15 22:41:37 +0100 2007
  author_url: http://maxmanders.co.uk
  author: max
  content: Nate, I certainly didn't mean to make an inflamatory comment against CakePHP. I just prefer the way things go in Symfony so far. That's not to say there won't come a point where I miss the ways of Cake and move back again.  I think it's important for developers to get experience with as many frameworks and platforms as possible as I am doing.  Just to clarify, CakePHP is an excellent framework - I just wanted to try Symfony :-)
  author_email: max@maxmanders.co.uk
  id: 1311
- date: Tue Aug 21 10:01:07 +0100 2007
  date_gmt: Tue Aug 21 10:01:07 +0100 2007
  author_url: http://twopointoh.co.uk/
  author: Paul Lomax
  content: Nate - Who's switching from Symfony to Cake? And why?
  author_email: paullomax@gmail.com
  id: 1339
- date: Wed Aug 22 07:41:37 +0100 2007
  date_gmt: Wed Aug 22 07:41:37 +0100 2007
  author_url: http://www.jurassicpunk.com/
  author: Tal Ater
  content: |-
    Those are all server and OS issues you're running into, not Symfony issues. Power through them and get to know the framework. It's great.
    I've switched to Symfony from CakePHP about a year and a half ago, and am very, very happy that I did... In fact I just started work on a new site two days ago, and once again chose Symfony.
  author_email: tal@talater.com
  id: 1345
- date: Wed Aug 22 09:45:22 +0100 2007
  date_gmt: Wed Aug 22 09:45:22 +0100 2007
  author_url: ""
  author: Bert-Jan
  content: |-
    If you application works fine when you access it with frontend_dev.php, but not without, you should clear the cache (run symfony cc).
    The dev-mode bypasses certain caches so you see changes happening as you're working. Not all caches are bypassed though, this can cause some trouble when e.g. you've added a new class in a lib directory. The cache that holds the lib locations is not bypassed in dev-mode.
    Just run symfony cc when something doesn't seem right. After that, if there's still a problem, there really is a problem.
  author_email: info@bert-jan.com
  id: 1348
- date: Wed Aug 22 10:53:44 +0100 2007
  date_gmt: Wed Aug 22 10:53:44 +0100 2007
  author_url: http://maxmanders.co.uk
  author: max
  content: I think I have resolved the problem now.  Either way, I've been using a proper MySQL database rather than SQLite since I'm more likely to use MySQL in a production environment.  Thanks.
  author_email: max@maxmanders.co.uk
  id: 1349
- date: Wed Aug 22 12:31:35 +0100 2007
  date_gmt: Wed Aug 22 12:31:35 +0100 2007
  author_url: ""
  author: halfer
  content: |-
    Database and URL rewriting issues such as these could well happen on Cake, or, indeed, any other framework; as Tal says, they're not down to symfony. I'm sure there are people moving from Cake to/from Symfony in both directions, and this is fine - people should use what they're happy with. Meanwhile, ongoing improvements to both keep the general quality of framework-driven PHP code high - competition is healthy :o)
    
    Max, if you do have further problems, and haven't already joined the symfony fora, then please do so - there's a number of people there happy to help out with related problems as well as symfony ones.
  author_email: blog.comments.1@jondh.me.uk
  id: 1350
author_email: max@maxmanders.co.uk
---
I've finally found time to start investigating some other PHP frameworks, and after some brief research I decided to start off with <a href="http://www.symfony-project.com">Symfony</a>.
All is going well and so far I'm impressed with what Symfony can do compared with CakePHP... with a few exceptions.

I initially tried following the My First Project tutorial, but hit problems pretty quickly.  It would seem that there was a problem with the PHP SQLite extension.  The phpinfo() function verified that SQLite was indeed installed, but I couldn't get any further on that trail.  After reading a number of forum posts on the issue, it became apparent I should recompile Apache and PHP.  I'm still not that confident with Linux to do that so I left it at that.

Then I followed the Askeet tutorial with more success as this tutorial uses MySQL rather than SQLite.  However, I can't get the URL rewriting to work as it should.  I've checked my Apache configuration, the .htacces file and still no luck. If I load http://project/question I get a 404 error.  If I load http://project/index.php/question or http://project/frontend_dev.php/question all is well.  I'll press on with this tutorial until I hit a road block, but this is really bugging me.  Again, a few forum posts suggest recompiling Apache and PHP.  However, the extensions that should be included in the new build are already present according to phpinfo().

I'm currently running Fedora 7 which installs Apache and PHP in its own odd way.  Perhaps I should start from scratch by  removing Apache and PHP with yum and compiling both from source.  Although as I said I'm kind of reluctant to do that.  If anyone has any ideas - let me know!
