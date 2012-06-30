--- 
tags: []

date: 2010-05-04 14:03:55 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/general/display-query-results-vertically-with-postgresql/
author: maxmanders
wordpress_id: 179
published: true
layout: post
categories: 
- Development
title: Display Query Results Vertically With PostgreSQL
comments: 
- date: Wed Mar 28 13:32:00 +0100 2012
  date_gmt: Wed Mar 28 13:32:00 +0100 2012
  author_url: http://code-zen.net/
  author: Peter Anselmo
  content: "Thanks!  I use both MySQL and Posgres often, and I've been wondering if there was a way to do this.  "
  author_email: peter_anselmo@yahoo.com
  id: 35116
author_email: max@maxmanders.co.uk
---
Those who are familiar with MySQL may be used to terminating a query with '\G' to have the client output the query results vertically with each column/value pair a line at a time.  There is in a equivalent in PostgreSQL too.  The psql client uses '\x' to toggle vertical output, and '\g' to send the current buffer to the server for processing.  To get the same effect in psql as '\G' in MySQL, just end your query with '\x\g\x'.
