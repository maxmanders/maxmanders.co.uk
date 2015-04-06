---
layout: post
title: "Working With Multiple Chef Orgs"
date: 2015-04-06 14:45:35 +0100
published: true
author: Max Manders
tags:
- chef
categories:
- chef
- devops
---
## The Problem
It's probably quite common that a lot of developers or operations engineers will typically
work with a couple of Chef organisations.  These organisations might represent the
infrastructure configurations for different products; or perhaps a _development_ and
_production_ environment, though this scenario is more often accomplished through the use of
different Chef environments.  But what if the nature of your work means you're dealing
with many Chef organisations at a time?  It could become quite cumbersome managing
individual working copies of different repositories representing the data you store in
various Chef orgs; not to mention maintaining subtly different Knife configurations, and
sets of user and _validator_ PEM keys.  So here's my solution to this problem.<!--more-->

## The Solution
The _Knife_ client will search in different standard locations until it finds a valid
`knife.rb` file.

  * `~/.chef/knife.rb`
  * `$(pwd)/.chef/knife.rb`

You might be used to managing an unversioned `.chef` directory in the root of your Chef
repository working copy.  Although you might exclude this via `.gitignore` it's very easy
to accidentally add it, and in so doing, you'll inadvertently add your Chef user PEM key,
and the validation key that lets nodes register with your Chef server!  A better approach
is to manage your various `Knife` configurations in a central location, say `~/.chef`.
You can version control those aspects that aren't private, and all you need to do is drop
the private files such as PEM keys in place.

I have a few utility functions in my `~/.zshrc` file [(you use Oh-My-ZSH,
right?!)](https://github.com/robbyrussell/oh-my-zsh).  I can use `kitchens` to list the
environments that I can work with; and I can use `cookwith <env_name>` to work on a
particular environment.

{% highlight bash %}
kitchens() {
    ls -1A ~/.chef | grep -vi knife
}
{% endhighlight %}

The `kitchens` function above simply lists the directory names that exist in my `~/.chef`
directory.  Each of those directories contains a structure like the one below:

{% highlight bash %}
╭─max@hedgehog  ~/.chef/maxmanders ‹ruby-2.1.5›
╰─$ pwd
/Users/max/.chef/maxmanders
╭─max@hedgehog  ~/.chef/maxmanders ‹ruby-2.1.5›
╰─$ tree
.
├── config.yml
├── maxmanders-validator.pem
└── maxmanders.pem

0 directories, 3 files
{% endhighlight %}

As you can see, each Chef org directory contains a YAML configuration file, a user PEM
key, and the validator key for that org.  The configuration file is parsed by my dynamic
`~/chef/knife.rb`:

{% highlight ruby linenos %}
CHEF_ENV = ENV["CHEF_ENV"] || "maxmanders"
current_dir = File.dirname(__FILE__)
env_config = YAML.load_file("#{current_dir}/#{CHEF_ENV}/config.yml")
cookbook_dir = "#{ENV["HOME"]}/chef/#{CHEF_ENV}"
 
log_level                :info
log_location             STDOUT
node_name                env_config["node_name"]
client_key               "#{current_dir}/#{CHEF_ENV}/#{env_config["node_name"]}.pem"
validation_client_name   env_config["validator"] || "chef-validator"
validation_key           "#{current_dir}/#{CHEF_ENV}/#{env_config["validator"]}.pem"
chef_server_url          env_config["server"]
cache_type               'BasicFile'
cache_options( :path => "#{current_dir}/#{CHEF_ENV}/checksums" )
cookbook_path            env_config["cookbook_paths"].collect { |x| "#{cookbook_dir}/#{x}" }
ssl_verify_mode          :verify_peer
{% endhighlight %}

This `knife.rb` file would be used to read a file named `config.yml` that might look
something like this:

{% highlight YAML %}
node_name: "maxmanders"
server: "https://api.opscode.com/organizations/maxmanders"
validator: "maxmanders-validator"
cookbook_paths:
  - "cookbooks"
  - "site-cookbooks"
{% endhighlight %}

I start off by setting the value of the *CHEF_ENV* I'm working with, based on the presence
of an environment variable named `CHEF_ENV`; if I don't have that environment set, I'll
default to my personal Chef org.  I then use Ruby's YAML module to parse the config file
found in the directory described earlier, based on `CHEF_ENV`.  The most important things
that afford the flexibility of working with multiple orgs are the locations of my PEM keys,
and the locations of my local cookbooks.

Once I have multiple directories in `~/.chef/`, all being listed when I run `kitchens`,
then I can use `cookwith`, below, to switch between them!

{% highlight bash %}
cookwith() {
    local chef_env=$1
    export CHEF_ENV=${chef_env}
    cd ~/chef/${chef_env}
}
{% endhighlight %}

At the end of this function, I change directory to a directory of the same name as my
chosen `CHEF_ENV` located in `~/chef/`.  This is where I store all of my repository
working copies.  For a lot of purposes, the local working copies aren't that important; I
might just be querying the Chef server with `knife`.  In these cases, I can just use a
symlink to some generic repository working copy.
