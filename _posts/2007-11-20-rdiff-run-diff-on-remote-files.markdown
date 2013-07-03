--- 
tags: []

date: 2007-11-20 16:59:28 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/linux/rdiff-run-diff-on-remote-files/
author: maxmanders
wordpress_id: 74
published: true
layout: post
categories: 
- Linux
title: rdiff - Run diff on remote files
comments: []

author_email: max@maxmanders.co.uk
---
A simple shell script that can be used to run a diff between local *and* remote files using scp.

    # A simple script that runs diff remotely using scp.
    # Parameters should use scp syntax, i.e.
    # [[user@][host:]]/path/to/file
    #
    #!/bin/sh
    if [ "$1" = "" -o "$2" = "" ]; then
        echo "Usage: `basename $0` file1 file2"
        exit 1
    fi
    
    scp $1 rdiff.1 >&amp; /dev/null
    scp $2 rdiff.2 >&amp; /dev/null
    diff -b rdiff.1 rdiff.2
    rm -f rdiff.1 rdiff.2
