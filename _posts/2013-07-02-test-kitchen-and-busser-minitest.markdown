--- 
date: 2013-07-02
layout: post
published: true
title: Test Kitchen and Minitest Busser
author: Max Manders
categories:
- chef
---
I've been keenly watching the evolution of the
[test-kitchen](https://github.com/opscode/test-kitchen) project and I've recently spent
some time using it with the minitest busser to validate that my cookbooks do what I
intended them to do.  Remember, Chef is already well covered by tests to ensure that e.g.
its various resources do what they say they'll do.  With that in mind, the key to using
test-kitchen is to write tests that validate your intentions, rather than testing that
Chef is doing what it's been asked.  This post will briefly describe my understanding of
how you might structure and write tests that use the minitest busser.  I'd also like to
extend a big thank you to [Fletcher Nichol](https://twitter.com/fnichol) and the rest of
the Opscode team and contributors who are making test-kitchen and related tools such
exciting projects to follow.

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

Test Kitchen is configured using a .kitchen.yml YAML file in the root of your cookbook
directory.  Whenever tests are run, a .kitchen/ directory will be created to store
configuration for your virtualisation platform of choice (e.g. Vagrnt with VirtualBox, EC2
etc.), and any log files that are generated.  This directory is created as necessary so
there's no harm in deleting it.

The .kitchen.yml I'm using looks like this:


{% highlight php linenos=table %}
for (var i = 0, len = ar.length; i < 0; i++) {
  newAr.push(ar[i].shift());
}
{% endhighlight %}

