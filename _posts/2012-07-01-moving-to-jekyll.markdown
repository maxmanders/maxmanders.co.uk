--- 
date: 2012-07-01 12:18:00
layout: post
title: Moving To Jekyll
author: Max Manders
tags: [jekyll, general]
categories:
- Jekyll
- General
- Linux
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
$ sudo apt-get install python-pygments
$ sudo apt-get install ruby-liquid
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
all my posts, appropriately named.  I copied this directory in to my own repository and
ran `jekyll --pygments` over it to make sure everything looked okay.

Having successfully migrated my existing content, getting the theme set up was a fairly
straight forward matter of copying my main Wordpress template into the `_layouts`
directory and adjusting the template variables to suit Jekyll, rather than calling
Wordpress template functions.

#### Deployment ####
Although I still have cause to use SVN, I favour Git for most revision-control matters.
Maintaining my blog is no exception, and it makes sense since all I'm really managing is
a collection of static text files.  I could have deployed to Github and used Github Pages to host
my blog, but I've chose to host things myself.  This was partly motivated by a desire
to control and take responsibility for everything, since I already have Git working perfectly
well on my server.  The other motivation to do it myself was that you require a paid
service to point a CNAME at Github Pages.  I don't have any use for private repositories
so don't use the paid service, and couldn't justify the small cost purely to allow
Github to host my blog.

So, ignoring the actual server deployment for now, the first thing I wanted was a
mechanism whereby I could edit a post in a markdown file, and have the static HTML
files in the `_site` directory automatically generated.

    {% highlight bash linenos %}
    #!/bin/sh

    echo "Building with Jekyll"
    jekyll --pygments
    git add -v -f _site
    {% endhighlight %}

The commands above live in `.git/hooks/pre-commit` and prior to actually adding the commit
to the index will run Jekyll and add the `_site` directory to the commit.  This is
necessary because I've explicitly ignored `_site` in my `.gitignore` file.

This is complimented by a post-receive hook that refreshes the live copy of the
repository.  I have a bare repository that I push to, and a virtual host configured that
points to a live clone of the bare repository.  When I push to my remote origin, the
following post-receive hook is run (`.git/hooks/post-receive`).

    {% highlight bash linenos %}
    #!/bin/sh

    GIT_REPO=/path/to/bare/repo
    PUBLIC_WWW=/path/to/live/copy

    rm -Rf $PUBLIC_WWW/*
    rm -Rf $PUBLIC_WWW/.*
    cd $PUBLIC_WWW
    git clone $GIT_REPO .
    exit
    {% endhighlight %}

This removes anything that's currently live and clones a fresh copy that includes my newly
added content. 

### Summary ###
I use a [Sitemap Generate plugin](https://github.com/kinnetica/jekyll-plugins) that is called when I run Jekyll, and updates my `sitemap.xml` file.
Draft posts are created using Git branches.  While there may be more succinct
or efficient methods for managing it all, this works for me.
