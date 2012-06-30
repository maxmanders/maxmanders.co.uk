--- 
tags: []

date: 2008-04-18 19:11:58 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=90
author: maxmanders
wordpress_id: 90
published: true
layout: post
categories: 
- Linux
title: "Firefox 2 on Gutsy: Bugfix"
comments: []

author_email: max@maxmanders.co.uk
---
I would expect that the Ctrl+Backspace key combination would behave in Firefox as it does in other GTK applications, and indeed Firefox under Win32.  The expected behavior is that Ctrl+Backspace will delete one word backwards from the cursor (more specifically it will delete backwards until a punctuation character).  However, when I use this combination in the Firefox address bar under Gutsy, the whole  URL is deleted.  After some digging I came up with a solution: add the following to the bottom of /etc/firefox/pref/firefox.js:

<pre><code>
// Make Ctrl+Backspace behave as expected.
pref("layout.word_select.stop_at_punctuation", true);</code></pre>
Hope this helps.
