--- 
date: 2013-02-24
layout: post
published: false
title: Installing proj4rb on Mountain Lion with Ruby 1.9.3
author: Max Manders
categories:
- ruby
---
A while ago I tinkered with the the Ordnance Survey Code-Point Open postcode data in PHP.
I never really maintained my little geocoding web app and decommissioned it when I started
generating this site with Jekyll, hosting it from AWS S3.  A change of jobs has meant a
change of primary language, which means I'm in the process of skilling up with Ruby.  So,
I'm revisiting my earlier endeavours with geocoding and map projections, but this time
with Ruby.

A few searches on Google suggested that the proj4rb Gem would do the heavy lifting of
converting coordinates in the Ordnance Survey OSGB36 system to the more familiar
latitute and longitude of the WGS84 system.  However, I ran in to a few problems trying to
use this Gem.

I'm using RVM with an installation of Ruby 1.9.3 and a dedicated Gemset for my project.
With this setup I first tried following the sumple instructions on the project's [Github
page](https://github.com/Caged/proj4rb#installation):

(% highlight bash %}
gem install proj4rb
{% endhighlight %}

Unfortunately this resulted in a slew of errors indicative of missing dependencies.  My
next stop was to following [the instructions](https://github.com/Caged/proj4rb#mac-os-x)
for compiling the Gem from source.  While I'm sure these instructions are perfectly
valid, for whatever reason, they didn't work for me.

I initially tried compiling and installing the C dependencies from the Proj project
manually, and then via MacPorts.  In the former case, I changed to the appropriate
directory in the RVM tree and tried ````make````.  This resulted in fewer compilation
errors, other than not being able to find "projects.h".
