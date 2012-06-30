--- 
tags: []

date: 2010-08-26 14:10:05 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=200
author: maxmanders
wordpress_id: 200
published: true
layout: post
categories: 
- YQL
title: Creating a Lifestream Widget with YQL
comments: []

excerpt: |-
  <h3>What is YQL?</h3>
  The Yahoo! Query Language (YQL) is a fantastic web service from the Yahoo! Developer Network (YDN) that can dramatically speed up development time if your application involves requesting data from multiple disparate web services and somehow combining that data.&nbsp; You can think of YQL as a gateway API that allows you to quickly and easily select, filter and combine data from across the web.
author_email: max@maxmanders.co.uk
---
<h3>What is YQL?</h3>
The Yahoo! Query Language (YQL) is a fantastic web service from the Yahoo! Developer Network (YDN) that can dramatically speed up development time if your application involves requesting data from multiple disparate web services and somehow combining that data.&nbsp; You can think of YQL as a gateway API that allows you to quickly and easily select, filter and combine data from across the web.<!--more-->
<h3>How to Use it</h3>
Although YQL is a Yahoo! hosted web service that you will ultimately need to query programatically you can start using it without reading much (if any) documentation thanks to the wonderfully designed <a title="YQL Console" href="http://developer.yahoo.com/yql/console/">YQL console</a>.

[caption id="attachment_205" align="alignnone" width="300" caption="Screenshot of the YQL console."]<img class="size-medium wp-image-205" title="Screenshot of the YQL console." src="/media/yqlconsole-300x175.png" alt="Screenshot of the YQL console." width="300" height="175" />[/caption]

The console is arranged in three main areas: the query input at the top; the results at the bottom; and a list of available tables and examples at the right.&nbsp; From the menu on the right, you can click on a table name and an example query will be inserted into the query input box and executed.&nbsp; Browsing through the tables and trying the example queries should give you a feel for the console.
<h3>An Example</h3>
As an example, let's say you want to find some photos of kittens from Flickr.
<pre class="brush:sql">select * from flickr.photos.search where text = 'kitten'</pre>
If you paste this into the input box and hit <em>enter</em> (or click <em>Test</em>) you will see the results appear in the results window, and a REST URL appear beneath that.&nbsp; The REST URL will be used shortly when we see how to use YQL in PHP.&nbsp; You can select either XML or JSON for the return data, and there's also a handy tree view to show you the results in a hierarchical tree structure.

[caption id="attachment_229" align="alignnone" width="300" caption="Searching for Flickr Kittens"]<img class="size-medium wp-image-229" title="Searching for Flickr Kittens" src="/media/yqlconsole-kitten-300x175.png" alt="Searching for Flickr Kittens" width="300" height="175" />[/caption]

By default, YQL only show tables for Yahoo! owned sites.&nbsp; However, the YQL project is extensible and community contribution is actively encouraged; more on this later.&nbsp; To see the complete list of tables, click the 'Show Community Tables' link.&nbsp; You could search Google for YQL:
<pre class="brush:sql">select titleNoFormatting, url, content, visibleUrl from google.search where q = 'yql'</pre>
There are even tables like html and rss to allow you to easily parse valid markup and RSS feeds.
<h3>Mixing in Some PHP</h3>
The YQL console is great for trying out queries and seeing how they work, but now we want to harness the power of YQL in some server-side code.&nbsp; For the most part this involves getting a URL from the console, and stirring in some cURL.
<pre class="brush:php">// Our query.
$yql = 'select * from flickr.photos.search where text = 'kitten'';

// Build a REST URL.
$url = 'http://query.yahooapis.com/v1/public/yql?q=' . urlencode($yql);

// Some cURL goodness.
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

// ...and execute.
$data = curl_exec($ch);
curl_close($ch);

// What did we get?
echo '<pre>';
print_r($data);
echo '</pre>';
</pre>
The returned XML is wrapped in a <code>query</code> element that has some useful metadata; but what we're interested in is the <code>results</code> element.
<h3>Creating a Lifestream</h3>
You can view a <a href="http://maxmanders.co.uk/lab/lifestream/">live demo of my lifestream</a>, which pulls in content from this blog, Flickr, Twitter, Delicious and LastFM.&nbsp; I've made it pretty using some CSS and JQuery (Hoverscroll Plugin).&nbsp; I've also borrowed from the YIU toolbox using the <a href="http://developer.yahoo.com/yui/grids/">YUI grids builder</a> to quickly throw together a layout.

The important bits of code follow, together with an explanation.&nbsp; You can find <a href="http://github.com/maxmanders/YQL-Lifestream">all the code on github</a>.&nbsp; First we build our YQL query and get the data.
<pre class="brush:php">$yql = 'SELECT title '
. ', link '
. ', pubDate '
. ', date '
. 'FROM rss '
. 'WHERE url IN ( '
.   '\'http://maxmanders.co.uk/feed\', '
.   '\'http://feeds.delicious.com/v2/rss/maxmanders\', '
.   '\'http://www.flickr.com/services/feeds/photos_public.gne?id=52727640@N00&amp;format=rss_200\' ,'
.   '\'http://ws.audioscrobbler.com/1.0/user/mmanders/recenttracks.rss\', '
.   '\'http://twitter.com/statuses/user_timeline/623503.rss\') '
. '| SORT(field="pubDate", descending="true")';

$endpoint = 'http://query.yahooapis.com/v1/public/yql?format=json&amp;env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&amp;diagnostics=false';
$url = $endpoint . '&amp;q=' . urlencode($yql);

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SET_VERIFYHOST, false);

$data = json_decode(curl_exec($ch));
curl_close($ch);
$data = $data->query->results->item;
</pre>
First we build a query to select from the <em>rss</em> table.&nbsp; This table models an RSS feed, and makes it easy to select common RSS fields.&nbsp; We use the syntax <code>WHERE url IN</code> to aggregate RSS feeds from multiple sources.&nbsp; Once we have the data, we want to sort the combined feed in descending order of publishing date.&nbsp; We can then iterate over the data, <a href="http://github.com/maxmanders/YQL-Lifestream/blob/master/index.php">and output a nice well structured table</a> (via GitHub).
<div id="_mcePaste" style="position: absolute; left: -10000px; top: 504px; width: 1px; height: 1px; overflow: hidden;"><img src="file:///tmp/moz-screenshot.png" alt="" /></div>
