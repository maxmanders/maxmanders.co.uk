--- 
tags: []

date: 2011-01-08 20:58:55 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=297
author: maxmanders
wordpress_id: 297
published: true
layout: post
categories: 
- YQL
title: Spotify YQL Table
comments: []

author_email: max@maxmanders.co.uk
---
I've updated <a title="maxmanders/yql-tables on GitHub" href="https://github.com/maxmanders/yql-tables">my fork</a> of the <a title="yql/yql-tables on GitHub" href="https://github.com/yql/yql-tables">yql-tables repository</a> to include a data table to wrap the <a title="Spotify Metadata API" href="http://developer.spotify.com/en/metadata-api/overview/">Spotify meta-data API</a>.&nbsp; I've issued a pull-request to the yql-tables maintainers so hopefully soon it should be included in the <a href="http://www.datatables.org/alltables.env">YQL environment</a>.&nbsp; However, I&nbsp; notice the last pull request from another user was made in November last year and still hasn't been answered; not sure if this suggests the project has stalled in some way.

Until it's included in the environment and therefore available via the console and the web service end-point, you can use the table via this site.
<pre class="brush: sql">-- Artist Search
USE 'http://maxmanders.co.uk/lab/spotify/spotify.search.artist.xml';
SELECT * FROM spotify.search.artist where artist = 'The New Pornographers';
-- Album Search
USE 'http://maxmanders.co.uk/lab/spotify/spotify.search.album.xml';
SELECT * FROM spotify.search.album where album = 'Together';
-- Track Search
USE 'http://maxmanders.co.uk/lab/spotify/spotify.search.track.xml';
SELECT * FROM spotify.search.track where track = 'Crash Years';
</pre>
