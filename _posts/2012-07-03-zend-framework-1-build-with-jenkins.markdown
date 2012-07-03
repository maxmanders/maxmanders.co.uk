--- 
date: 2012-07-03 10:00:00
layout: post
title: Zend Framework 1 Build With Jenkins
author: Max Manders
categories:
- php
tags: [ci, php, jenkins, linux, apache]
---

It's high time I that got up to speed on testing best practices.  I've dabbled with
Selenium, SimpleTest and PHPUnit, but not in any way comprehensively.  I've read and
thoroughly enjoyed [@grmpyprogrammer's](http://twitter.com/grmpyprogrammer)
[book](http://leanpub.com/grumpy-testing), and you should too.

However, I don't have the opportunity to exercise these interests in my current job,
so I've taken it upon myself to learn in my own time with a pet-project I'm working
on.<!--more-->
The details of the application aren't important for the purposes of this post, but some
specifics about the environment and tools I'm using are:

* Zend Framework 1.11
* Doctrine 2
* Apache 2
* MySQL

I've been learning Zend Framework on and off for a while now, and until things look more
promising on the ZF2 front, I'm sticking with what I know in ZF1.  I don't doubt that ZF2
will be released soon, and will be a great framework, but for educational purposes, I'd
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
version of PHPUnit.  In a similar fashion, testing controllers by extending Zend Framework
classes that themselves extend PHPUnit classes will not work in ZF1 against PHPUnit 3.6.

After some trial and error, I managed to install PHPUnit 3.5.3 and the other tools I need
for the build.

    {% highlight bash linenos %}
    $ sudo pear channel-discover pear.phpunit.de
    $ sudo pear channel-discover  components.ez.no
    $ sudo pear channel-discover pear.phing.info
    $ sudo pear channel-discover pear.phpunit.de
    $ sudo pear channel-discover pear.phpmd.org
    $ sudo pear channel-discover pear.pdepend.org
    $ sudo pear channel-discover pear.phpdoc.org
    $ sudo pear install pear.symfony-project.com/YAML-1.0.2
    $ sudo pear install phpunit/PHPUnit_Selenium-1.0.1
    $ sudo pear install phpunit/Text_Template-1.0.0
    $ sudo pear install phpunit/PHPUnit_MockObject-1.0.3
    $ sudo pear install phpunit/PHP_Timer-1.0.0
    $ sudo pear install phpunit/File_Iterator-1.2.3
    $ sudo pear install phpunit/PHP_TokenStream-1.0.1
    $ sudo pear install phpunit/PHP_CodeCoverage-1.0.2
    $ sudo pear install phpunit/DbUnit-1.0.0
    $ sudo pear install phpunit/PHPUnit-3.5.15
    $ sudo pear install pear.phpunit.de/phploc-1.6.0
    $ sudo pear install php_CodeSniffer
    $ sudo pear install phpdoc/phpDocumentor-alpha
    $ sudo pear install pear.phpunit.de/PHP_CodeBrowser-1.0.0
    $ sudo pear install phpdoc/phpDocumentor-2.0.0a1
    $ sudo apt-get install php5-xsl
    $ sudo apt-get install graphviz
    $ sudo apt-get install jenkins
    $ sudo apt-get install ant
    {% endhighlight %}


The above commands install the necessary tools for my build.  So what does the build file
actually look like?  It's nothing original on my part, but comes courtesy of [Jenkins PHP
project](http://jenkins-php.org/).  In fact, other than installing the appropriate
versions of the tools such that we can continue using PHPUnit 3.5 the rest of the steps are
straight from http://jenkins-php.org.

This is all good and well for running a local Jenkins instance, but this would be much
more useful if it was installed on a remote server!  Out-of-the-box, Jenkins doesn't
require authentication, and will happily sit open to the world on port 8080.  So, I chose
to create a subdomain A record and VirtualHost and stick Jenkins behind basic HTTP
authentication.

    {% highlight apache linenos %}
    <VirtualHost {ip}:80>
      ServerName {fqdn}
      ServerAdmin max@maxmanders.co.uk

      ErrorLog /path/to/error.log
      LogLevel warn
      CustomLog /path/to/access.log combined

      ProxyPass           / http://localhost:8080/
      ProxyPassReverse    / http://localhost:8080/
      ProxyRequests Off

      <Proxy http://localhost:8080/>
        Order Deny,Allow
        Allow From All
      </Proxy>

      <Location />
        Allow From All
        AuthType basic
        AuthName "{authentication_message}"
        AuthUserFile "/path/to/htpasswd_file"
        Require User {secure_user}
      </Location>

    </VirualHost>
    {% endhighlight %}

And we can create the password file using, e.g. `sudo htpasswd -c /path/to/password_file {user}`.
We start Jenkins on the server, only binding to `localhost`.  The above VirtualHost tells Apache
to respond to requests for the server name, but to pass them off to the service listening on
`localhost:8080`, i.e. Jenkins.  But before Apache will handle the request, we need to successfully
authenticate.

With this configuration in place, the instructions on [Jenkins PHP project](http://jenkins-php.org/)
for setting up a project by copying the example PHP template project can be followed to
get a successful build working. 
