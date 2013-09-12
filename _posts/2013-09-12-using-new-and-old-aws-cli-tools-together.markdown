--- 
date: 2013-09-12
layout: post
published: true
title: Using New And Old AWS CLI Tools Together
author: Max Manders
categories:
- aws
---
I've been using the newer AWS CLI tools for quite a while now, and while they are for the
most part a vast improvement over the older Java tools, there are times where the legacy
versions come in handy.  I'd therefore like to be able to use both the new and old tools
without too much effort.  Both new and old tools depend upon certain environment variables
being present, and these environment variables will take priority over any profiles
defined for the newer tools.<!--more-->

I have the newer tools installed following the recommended practice of
{% highlight bash %} pip install awscli {% endhighlight %} and a profile configuration file that lives
in _~/.awsconfig_.

I'm using Git to manage different environments for the older CLI tools.  I have a Git
repository with no remotes in _~/.aws-tools_.  My _.gitconfig_ is configured to ignore
_.bin/_ and _.lib/_.  This allows me to install all of the binaries for the old tools in a
common location.  I then have a separate branch for each environment I want to use, and
each branch contains committed credentials for that environment.  __This is why there are
no remotes associated with this repository; that would be very very bad.__ 

To switch environments, I effectively check out the appropriate branch and export
environment variables.  That approach can get qutie cumbersome.  Also, if I forget to
unset certain envrionment variables before trying to use the new CLI tools, it can screw
around with the profiles.  To illustrate this, a typical environment branch might look
like this:

      ~/.aws-tools/
      └── bin/
      └── lib/
      ├── some-env.cert.pem
      ├── some-env.pk.pem
      └── some-env.credentials

To make things a little easier, I've written a function that you can add to your
_~/.bashrc_ or _~/.zshrc_ that will allow you to list environments; unset all the
environment variables so that you may use the newer tools; and switch to a particular
environment.  Remember to _source ~/.zshrc_ to start using the new function:

    # Lists branches / environments
    aws-manage
    # Disables the old tools by unsetting environment variables
    aws-manage off
    # Enable a particular branch / environment
    aws-manage some-env

And here's the function that does the magic.

{% highlight bash %}
aws-manage() {
    export EC2_HOME=~/.aws-tools

    if [ "$1" = "off" ]; then
        unset EC2_ACCESS_KEY
        unset EC2_SECRET_KEY
        unset EC2_CERT
        unset EC2_PRIVATE_KEY
        unset EC2_PRIVATE_KEY
        unset EC2_CERT
        cd $EC2_HOME && git checkout master | cd -
        unset EC2_HOME
        echo "ec2: off!"
    else
        if [[ -z "$1" ]]; then
            cd $EC2_HOME
            git branch
            cd -
            return
        fi

        if [[ "cd $EC2_HOME | git branch | grep $1" = *$1 ]]; then
            cd $EC2_HOME && git checkout $1 | cd -
            echo "ec2: $1!"
        else
            echo "$1 is not a valid ec2 branch"
        fi

        export PATH=$PATH:$EC2_HOME/bin
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
        export EC2_ACCESS_KEY=$(head -n1 $EC2_HOME/*.credentials | cut -d"=" -f2)
        export EC2_SECRET_KEY=$(tail -n1 $EC2_HOME/*.credentials | cut -d"=" -f2)
        export EC2_PRIVATE_KEY=$(ls $EC2_HOME/*.pk.pem)
        export EC2_CERT=$(ls $EC2_HOME/*.cert.pem)
    fi
}
{% endhighlight %}
