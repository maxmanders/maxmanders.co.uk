--- 
tags: []

date: 2012-01-05 22:54:10 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=482
author: maxmanders
wordpress_id: 482
published: true
layout: post
categories: 
- Linux
title: Missing LaTeX 'Glossaries' Package In Ubuntu
comments: 
- date: Mon Apr 30 08:37:00 +0100 2012
  date_gmt: Mon Apr 30 08:37:00 +0100 2012
  author_url: http://profiles.google.com/philipp.kern
  author: Philipp Kern
  content: It's in texlive-latex-extra. Since ages.
  author_email: philipp.kern@gmail.com
  id: 35117
excerpt: I had cause to use the <code>glossaries</code> package in <code>LaTeX</code> today to take care of all my glossary management needs. &nbsp;The idea of being able to create an external file to define all of my acronyms and definitions, and then include them as required in a separate section that is automatically included in a table of contents is very appealing. &nbsp;Unfortunately, the <code>glossaries</code> package isn't installed as part of the Ubuntu <code>texlive-latex-*</code> packages, nor is it separately installable via Aptitude.
author_email: max@maxmanders.co.uk
---
I had cause to use the <code>glossaries</code> package in <code>LaTeX</code> today to take care of all my glossary management needs. &nbsp;The idea of being able to create an external file to define all of my acronyms and definitions, and then include them as required in a separate section that is automatically included in a table of contents is very appealing. &nbsp;Unfortunately, the <code>glossaries</code> package isn't installed as part of the Ubuntu <code>texlive-latex-*</code> packages, nor is it separately installable via Aptitude.<!--more--> &nbsp;I had expected that something as common as glossary management would be included, bud sadly that's not the case.

Thankfully, the TexLive installation is quite modular, and it's relatively straight forward to install new environments and packages. Through trial and error, I've discovered the missing packages required to use <code>glossaries</code> are: <code>glossary</code>, <code>glossaries</code>, <code>xfor</code> and <code>etoolbox</code>.

Firstly, we need to find the location to install local <code>tex</code> packages
<pre class="brush: bash">[max@dolphin ~] $ kpsewhich -expand-var "\$TEXMFLOCAL"
/usr/local/share/texmf</pre>
Now that we know where to install the packages, we can download and install them. The following redacted typescript will download and extract the packages to the appropriate local location and rebuild the <code>LaTeX</code> package map.
<pre class="brush: bash">[max@dolphin ~] $ wget http://mirror.ctan.org/macros/latex/contrib/glossary.zip -P /tmp/
[max@dolphin ~] $ wget http://mirrors.ctan.org/install/macros/latex/contrib/glossaries.tds.zip -P /tmp/
[max@dolphin ~] $ wget http://mirrors.ctan.org/install/macros/latex/contrib/xfor.tds.zip -P /tmp/
[max@dolphin ~] $ wget http://mirrors.ctan.org/install/macros/latex/contrib/etoolbox.tds.zip -P /tmp/
[max@dolphin ~] $ sudo unzip /tmp/glossaries.tds.zip -d /usr/local/share/texmf
[max@dolphin ~] $ sudo unzip /tmp/xfor.tds.zip -d /usr/local/share/texmf
[max@dolphin ~] $ sudo unzip /tmp/etoolbox.tds.zip -d /usr/local/share/texmf
[max@dolphin ~] $ sudo mkdir -p /usr/local/share/texmf/tex/latex/{contrib,html}
[max@dolphin ~] $ cd /tmp/
[max@dolphin ~] $ unzip glossary.zip &amp;&amp; cd glossary
[max@dolphin glossary] $ latex glossary.ins
[max@dolphin glossary] $ sudo cp glossary.sty /usr/local/share/texmf/tex/latex/contrib/
[max@dolphin glossary] $ sudo cp glossary.perl /usr/local/share/texmf/tex/latex/html/
[max@dolphin glossary] $ cd /usr/local/share/texmf/
[max@dolphin glossary] $ sudo texhash</pre>
