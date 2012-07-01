--- 
date: 2012-07-01 12:18:00
layout: post
title: Moving To Jekyll
author: Max Manders
---

I've been using [Wordpress](http://www.wordpress.org "Wordpress") to maintain
my blog since early 2007.  I have absolutely no complaints about Wordpress;
it's a fantastic blogging platform and CMS for users of all skill levels.  However, I
spend most of time at the command line, and use Vim as my text editor of choice.  For
those reasons, a trend I've seen among other developers of using 
[Jekyll](https://github.com/mojombo/jekyll/) very much appeals to me.
<!--more-->

### About Jekyll ###
Jekyll is a '...blog-aware, static site generator in Ruby...'.  At an extremely
high level, It allows you to write pages and blog-posts using markdown syntax,
and with a single command, mashes the markdown together with user-defined
templates to generate static HTML files.  Although I'm a PHP developer with no Ruby
skills whatsoever, that doesn't matter -- it's an extremely efficient and effective
tool, hosted on [Github](http://github.com) and is comprehensively documented.

### How ###
Having read a number of web pages and guides, I concluded the most appropriate approach
for my purposes would be to maintain my content history as a Git repository.  This
would allow me to write my posts locally, and use a pre-commit hook to generate and add
any new HTML files to the repository.  I could then deploy by pushing to a remote on
my server, which would refresh the copy using a post-receive hook.
  
I identified the following steps would be required in order to migrate my
existing Wordpress installation to use Jekyll:

1. Install Jekyll and its dependencies.
2. Migrate existing Wordpress posts to markdown files.
3. Migrate existing Wordpress theme for use with Jekyll.
4. Configure deployment.

#### Installation ####
From what I've read, I believe that the preferred way of managing third-party
Ruby packages, or RubyGems, is via the Gem package manager; similar in some
respects to Pear for PHP. However, in the past I've had varying mileage using
that method, so I've chosen to stick the official Ubuntu packages.  The
following instructions apply to Ubuntu 12.04.

{% highlight bash linenos %}
$ sudo apt-get install ruby
$ sudo apt-get install rubygems
$ sudo apt-get install libmysql-ruby1.9.1
$ sudo apt-get install libhtmlentities-ruby1.9.1
$ sudo gem install jekyll 
{% endhighlight %}

#### Migration ####
The data migration was relatively straight forward, thanks to Jekyll's out-of-the-box
support for exporting Wordpress posts to markdown files.  First, I took a dump of my
live database and imported it to my local machine.  Then, I took a clone of the
Jekyll source and used the migration utility, as documented.

{% highlight bash linenos %}
git clone https://github.com/mojombo/jekyll.git
export DB=my_wp_database
export USER=my_wp_user
export PASS=my_wp_pass
ruby -r '~/tmp/jekyll/lib/jekyll/migrators/wordpress' \
  -e 'Jekyll::WordPress.process( "#{ENV["DB"]}", "#{ENV["USER"]}", "#{ENV["PASS"]}")'
{% endhighlight %}

This resulted in the creation of a `_posts` directory, filled with markdown versions of
all my posts, appropriately named.
