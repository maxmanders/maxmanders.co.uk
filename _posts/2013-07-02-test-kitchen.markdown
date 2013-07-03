--- 
date: 2013-07-02
layout: post
published: true
title: Using Test Kitchen
author: Max Manders
categories:
- chef
---
I've been keenly watching the evolution of the
[test-kitchen](https://github.com/opscode/test-kitchen) project and I've
recently spent some time using it with the minitest busser to validate that my
cookbooks do what I intended them to do.  Remember, Chef is already well
covered by tests to ensure that e.g.  its various resources do what they say
they'll do.  With that in mind, the key to using test-kitchen is to write tests
that validate your intentions, rather than testing that Chef is doing what it's
been asked.  This post will offer a brief introduction to test-kitchen, with a
focus on writing tests using the Minitest Busser.  I'd also like to extend a
big thank you to [Fletcher Nichol](https://twitter.com/fnichol) and the rest of
the Opscode team and contributors who are making test-kitchen and related tools
such exciting projects to follow.<!--more-->

To get started, you'll need the following Gems installed (I've listed the versions I'm
using; I had a few issues resolving dependencies, so this is left as an excersise for the
reader):

 * busser (0.4.1)
 * busser-minitest (0.2.0)
 * chef (11.4.4)
 * kitchen-ec2 (0.5.1)
 * kitchen-vagrant (0.10.0)
 * test-kitchen (1.0.0.dev)

I'm using the Vagrant 1.2.2 PKG package for OSX, and I've installed test-kitchen from
source rather than using rubygems.org.  I'd recommend installing these dependencies in
their own Gemset using RVM.

I'll also be making reference to my contrived test cookbook, available on
[Github](https://github.com/maxmanders/minitest-busser-example).

test-kitchen is configured using a .kitchen.yml YAML file in the root of your
cookbook directory.  If your cookbook depends upon other community cookbooks,
you can use [Berkshelf](http://berkshelf.com/) via a Berksfile file to define
those dependencies.  The extra cookbooks will then be downloaded and included
as part of a Chef run.

Whenever tests are run, a .kitchen/ directory will be created to store
configuration for your virtualisation platform of choice (e.g. Vagrant with VirtualBox, EC2
etc.), and any log files that are generated.  This directory is created as necessary so
there's no harm in deleting it.

In my example, I've defined three recipes: default, foo and bar.  Each of these recipes
copies a simple text file to a location defined by an attribute.

Continuing the culinary nomenclature, the various *providers* that can be use to run the 
tests are called *Bussers*.  You can use multiple *Bussers* in each suite of tests by
saving your tests in an appropriate directory structure.

      test
      └── integration
          ├── bar
          │   └── minitest
          │       └── test_bar.rb
          ├── default
          │   └── minitest
          │       └── test_default.rb
          └── foo
              └── minitest
                  └── test_foo.rb

In my case, I've defined a separate suite per recipe in my .kitchen.yml file:

   {% highlight yaml %}
   ...
   suites:
   - name: default
     run_list:
       - recipe[foobar]
     attributes: {} 
   - name: foo
     run_list:
       - recipe[foobar::foo]
     attributes: {} 
   - name: bar
     run_list:
       - recipe[foobar::bar]
     attributes: {} 
   ...
   {% endhighlight %}

All tests are stored in the ``test/integration/`` directory, with a directory named after
each test suite.  Each test suite directory in turn contains a directory named after the
busser being used.  In this case, I've indicated that I want to use the Minitest busser
by creating a ``minitest/`` directory in each test suite directory.  I could use a
different busser such as Bats by creating a ``bats/`` directory at the same level as the
``minitest/`` directory.

The actual tests are written using Minitest.  In this case, I'm asserting that the file
I intended to create has indeed been created.  This does contradict my earlier suggestion
that test-kitchen tests should verify intention, rather than Chef primitives, but this is
a contrived example.

   {% highlight ruby %}
   require 'minitest/autorun'

   describe "foobar::default" do

     it "has created foobar.txt" do
       assert File.exists?("/usr/local/foobar.txt")
     end
   end
   {% endhighlight %}

Note that in order for the tests to be picked up, they must either be named with a
leading ``test_`` in the filename, or with a trailing ``_spec`` in the filename.  In both
cases, since these are Ruby files, they should have a ``.rb`` extension.

In order to run the tests, simply run ``kitchen test``.  If your tests pass, a nice
summary will be displayed in the output at the concusion of each test suite run.  If your
tests fail, the `kitchen` process will terminate, with logs being written to the terminal
and in ``.kitchen/logs``!
