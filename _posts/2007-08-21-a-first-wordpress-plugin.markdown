--- 
tags: []

date: 2007-08-21 22:41:48 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/development/a-first-wordpress-plugin/
author: maxmanders
wordpress_id: 59
published: true
layout: post
categories: 
- Development
title: A First Wordpress Plugin
comments: []

author_email: max@maxmanders.co.uk
---
As you can see from my previous post, my first attempt at writing a Wordpress Plugin was a success.  This plugin is very simple and allows the user to embed a YouTube video into their post.  The main function calls a callback function that replaces every occurrence of the tag ["youtube" video_id] (minus quotes) with a flash video corresponding to the video_id parameter.

Just paste the code below into a file called 'youtube.php' in your wp-content/plugins directory. You should then be able to activate it via the Plugins admin option.  Once activated, you can place a YouTube video in your post by going to code-view and inserting  ["youtube" video_id] (minus the quotes). The video_id parameter is the 'v' parameter in a YouTube URL. In the example below, the URL is http://www.youtube.com/watch?v=lL4L4Uv5rf0.  Therefore, the video_id parameter should be lL4L4Uv5rf0.  In the code below, you will need to remove the quotes around the word "youtube" in the regex on line 5, I had to put these in to display the code without it interpreting the tag... it's a work in progress!
<pre lang="php">

define("YOUTUBE_WIDTH", 425);
define("YOUTUBE_HEIGHT", 350);
define("YOUTUBE_TAG", "/["youtube" ([[:print:]]+)]/");
define("YOUTUBE_LINK", "<object type="\" data="\" height="\" width="\">
<param name="\" value="\"></param></object>");

function youtube_plugin_cb($match)
{
$html = YOUTUBE_LINK;
$html = str_replace("###YOUTUBE_ID###", $match[1], $html);
return ($html);
}

function youtube_plugin($content)
{
return (preg_replace_callback(YOUTUBE_TAG, 'youtube_plugin_cb', $content));
}

add_filter('the_content', 'youtube_plugin');
add_filter('comment_text', 'youtube_plugin');

?></pre>
