--- 
tags: []

date: 2010-03-31 20:42:40 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=156
author: maxmanders
wordpress_id: 156
published: true
layout: post
categories: 
- Web Development
title: YQL Nutritional Data
comments: []

author_email: max@maxmanders.co.uk
---
My todo list has been telling me to play with Yahoo's <a title="YQL on YDN" href="http://developer.yahoo.com/yql/">YQL</a> for far too long now, so last night I did something about it.&nbsp; YQL is a Yahoo SQL-like language that allows developers to easily aggregate data from various disparate data sources without having to go through the rigmarole of writing their own API.&nbsp; There is a large selection of base tables that allow the developer to work with e.g. <a href="http://www.flickr.com">Flickr</a> or <a href="http://www.upcoming.org">Upcoming</a>.&nbsp; There is also a community contributed selection of tables (see <a href="http://datatables.org">datatables.org</a>).&nbsp; You can contribute to the project by forking the GitHub project and sending a pull request once you've committed changed to your tree.

That's exactly what I did last night.&nbsp; I did some digging and found the UK government's data source for nutritional information, the <a title="Composition of Foods" href="http://www.food.gov.uk/science/dietarysurveys/dietsurveys/">"Composition of Foods" report</a>.&nbsp; To use the data, I had to apply for a free <a title="OPSI Click Use Licensing" href="http://www.opsi.gov.uk/click-use/index">Click-Use license</a>.&nbsp; I didn't have to specify what data I was using or how I was going to use it; it seemed more the case that I had to have my name added to a list of people who use government data in some way, shape or form.&nbsp; Once I'd munged the data a bit, I created a CSV, and corresponding XML file as described by the DataTables documentation.

You can use my DataTable by querying YQL (or in the YQL-console) like this for example:
      use "http://maxmanders.co.uk/lab/nutritionals/nutritionals.xml";
      select * from nutritionals where name = 'banana';
