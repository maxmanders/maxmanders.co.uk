--- 
tags: []

date: 2009-11-19 15:52:55 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=145
author: maxmanders
wordpress_id: 145
published: true
layout: post
categories: 
- Python
title: Python Lambda Expressions
comments: []

excerpt: I've been writing a small Python/Tk application and until recently was having trouble with menu item callback functions.&nbsp; I have a series of menu items, all of which do much the same thing, but within the context of an item-specific ID.&nbsp; Therefore it would make sense to have a generic function that takes some parameter to determine what to do.
author_email: max@maxmanders.co.uk
---
I've been writing a small Python/Tk application and until recently was having trouble with menu item callback functions.&nbsp; I have a series of menu items, all of which do much the same thing, but within the context of an item-specific ID.&nbsp; Therefore it would make sense to have a generic function that takes some parameter to determine what to do.<!--more-->

However, when adding a menu item and callback, e.g.
<pre class="brush:python">
menu.add_command(label = someLabel, command = someCallback)
</pre>

you must pass in the name of a function, rather than a function call.  To get around this, I used a lambda function to pass in a previously defined value to a callback:
<pre class="brush:python">
id = some_value
menu.add_command(label = someLabel, command = lambda id=id: someCallback(id))
</pre>
