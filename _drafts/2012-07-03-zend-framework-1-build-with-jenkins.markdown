--- 
date: 2012-07-03 10:00:00
layout: post
title: Zend Framework 1 Build With Jenkins
author: Max Manders
---

It's high time I that got up to speed on testing best practices.  I've dabled with
Selenium, SimpleTest and PHPUnit, but not in any way comprehensively.  I've read and
thoroughly enjoyed [@grmpyprogrammer's](http://twitter.com/grmpyprogrammer)
[book](http://leanpub.com/grumpy-testing), and you should too.

However, I don't have the opportunity to excercise these interests in my current job,
so I've taken it upon myself to learn in my own time with a pet-project I'm working on.
The details of the application aren't important for the purposes of this post, but some
specifics about the environment and tools I'm using are:

  * Zend Framework 1.11
  * Doctrine 2
  * Apache 2
  * MySQL

I've been learning Zend Framework on and off for a while now, and until things look more
promising on the ZF2 front, I'm sticking with what I know in ZF1.  I don't doubt that ZF2
will be release soon, and will be a great framework, but for educational purposes, I'd
prefer to stick with something consistent that doesn't have a danger of becoming instantly
obsolete or broken from backward incompatibilities that may have been introduced.

There are any number of highly rated continuous integration applications available at the
moment, and although not entirely arbitrarily, I opted to investigate using
[Jenkins](http://jenkins-ci.org).  That lead me to [Sebastian
Bermann's](http://sebastian-bergmann.de/) [Jenkins PHP project](http://jenkins-php.org/).
I followed the steps outlined on the site, but it quickly became apparent through errors
and some Google verification that this wasn't going to work for me out-of-the-box.

Zend Framework 1.x is supported by a significant number of PHPUnit unit tests, which were
written against PHPUnit &le; 3.5.3.  When PHPUnit 3.6 was released, I understand it was
significantly refactored, making the existing ZF1 test suite incompatible with the new
version of PHPUnit.
