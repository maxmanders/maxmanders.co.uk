--- 
tags: []

date: 2007-08-22 16:47:47 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/development/analysing-oracle-application-server-9i-webcache-logs/
author: maxmanders
wordpress_id: 49
published: true
layout: post
categories: 
- Development
title: Analysing Oracle Application Server 9i Webcache Logs
comments: []

excerpt: Recently I had cause to report on the usage staff at work made of the corporate intranet. This would ordinarily be a simple enough task if the logs were plain standard Apache logs. However, I was dealing with Oracle9iAS, a very different beast indeed.  Oracle9iAS is built on top of a customised version of Apache and incorporates a caching proxy server, the so-called Webcache; an implementation of J2EE called OC4J (Oracle Containers for Java) and various other bells and whistles, making it something of a behamoth.
author_email: max@maxmanders.co.uk
---
Recently I had cause to report on the usage staff at work made of the corporate intranet. This would ordinarily be a simple enough task if the logs were plain standard Apache logs. However, I was dealing with Oracle9iAS, a very different beast indeed.  Oracle9iAS is built on top of a customised version of Apache and incorporates a caching proxy server, the so-called Webcache; an implementation of J2EE called OC4J (Oracle Containers for Java) and various other bells and whistles, making it something of a behamoth.<!--more-->

Because we use the Webcache, I would need to analyse the Webcache access logs for a representative picture of what people are requesting.  However, the Webcache does not use a single log file; it uses rolling log files for each day named <access_log.YYYYMMDD>.  Also, Webcache does not use a standardised logfile format, it uses a format unique (as far as I know) to Oracle.

My task was to extract the relevant data from the various logfiles. I was only interested in "pages" from Oracle Portal.  In this case, a page is a specific Oracle Portal entity, rather than a more genereal web page as you might think.  I wrote a small Perl script to grab the necessary lines from each logfile and write them to a file that I would later process with Analog.
<pre lang="Perl">
#!/usr/bin/perl</code>

# USE directives
use Time::Local;
use File::Find;
use Cwd;

# -----------------------------------------------

# Get elements of the current datetime
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime(time);
my $cwd = getcwd();
my $extension;
my $regex;
my $line;
my $pause;
my $thisfile;

# Convert year to four digit YYYY format rather than 'year - 1900'
$year = $year + 1900;

# If the month is January, i.e. $mon == 0, then we need to process log files
# from the previous year as well as the previous month, i.e. December or
# $mon == 12.
if ($mon == 0)
{
  $mon = 12;
  $year -= 1;
}

# Construct logfile extension as YYYYMM where MM is previous MM.
$extension = length($mon) == 1 ? "$year" . "0" . $mon : "$year" . $mon;

# File to output results to.
$outfile = "input.log";

# Regex to match Portal page URIs.
$regex = '^.*\t/portal/page\?_pageid.*$';

# Run File::Find::find() against each file in the current directory.
find(\&amp;get_date, $cwd);

##
# Callback function for File::Find
# This function is called for every file found in $cwd
##
sub get_date
{
  my $line;
  my @output_list;
  my @input_list;

  # only read log files for previous month
  if ($File::Find::name =~ /access_log\.$extension.*$/)
  {
    $thisfile = $File::Find::name;

    # test whether the file we are looking at is a compressed
    # file or not
    if ((substr($File::Find::name, -1)) eq "Z")
    {
      # if it is compressed, uncompress it and
      # take name of file without .Z as the file
      # to operate on afterwards
      print "Uncompressing $File::Find::name...";
      system("uncompress $File::Find::name");
      $thisfile = substr($File::Find::name, 0, -2);
    }
    print "$thisfile\n";
    open(IN_FILE, $thisfile) or die ("Cannot Open File: $!\n");
    open(OUT_FILE, ">>$outfile") or die ("Cannot Open File: $!\n");
    while ($line = <in_file>)
    {
      if ($line =~ $regex)
      {
        print $line;
        print OUT_FILE ($line);
      }
    }
    close(IN_FILE);
    close(OUT_FILE);</in_file>
    
    if ((substr($File::Find::name, -1)) eq "Z")
    {
      # If we uncompressed a compressed file then
      # we must now recompress it.
      $zipfile = substr($File::Find::name, 0, -2);
      print "Compressing $zipfile...";
     system("compress $zipfile");
    }
  }
}
</pre>
