--- 
title: Display PostgreSQL Query Results Vertically
layout: post
---

Those who are familiar with MySQL may be used to terminating a query with `\G` to have the client output the query
results vertically with each column/value pair a line at a time. There is in a equivalent in PostgreSQL too. The `psql`
client uses `\x` to toggle vertical output, and `\g` to send the current buffer to the server for processing. To get the
same effect in psql as `\G` in MySQL, just end your query with `\x\g\x`.

<!--more-->
