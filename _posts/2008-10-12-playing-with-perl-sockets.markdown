--- 
tags: []

date: 2008-10-12 18:47:08 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=99
author: maxmanders
wordpress_id: 99
published: true
layout: post
categories: 
- General
- Web Development
- Linux
- PHP
- Perl
title: Playing With Perl Sockets
comments: 
- date: Mon Mar 28 13:53:09 +0100 2011
  date_gmt: Mon Mar 28 12:53:09 +0100 2011
  author_url: http://web-developer.classyscripts.com/
  author: CMS
  content: Great read. As usual I find all your posts very informative and I wanted to take this opportunity to let you know that.
  author_email: perl@gmail.com
  id: 17777
excerpt: At work, I have a <a href="http://www.snom.com/en/products/snom-360-voip-phone/">Snom 360</a> IP phone that is hooked up to our internal <a href="http://www.asterisk.org/">Asterisk</a> PBX.&nbsp; If I'm listening to music with my headphones in, I'm not always aware that my phone is ringing - some Perl and PHP hacking later, I've got a crude (and work-in-progress) solution.
author_email: max@maxmanders.co.uk
---
At work, I have a <a href="http://www.snom.com/en/products/snom-360-voip-phone/">Snom 360</a> IP phone that is hooked up to our internal <a href="http://www.asterisk.org/">Asterisk</a> PBX.&nbsp; If I'm listening to music with my headphones in, I'm not always aware that my phone is ringing - some Perl and PHP hacking later, I've got a crude (and work-in-progress) solution.<!--more-->

The phone has an internal web server that lets the user customise a number of options.&nbsp; The one I'm interested in is 'Action URI'.&nbsp; When a call comes through to my phone, I can enter a URI that my phone will request.&nbsp; I can send arbitrary parameters in the query string, e.g. a message or the phone number of the caller.&nbsp; My solution involves a PHP script that the phone can request, a simple Perl socket server sitting listening on my laptop, and a simpel Perl Tk script that will open a window to alert me to the call.

The PHP script that my phone requests is quite simple:

    // Hostname of machine
    $host = 'somehost';
    // Port to connect to
    $port = '7890';
    $timeout = 30;
    $message = $_GET['message'];
    
    $socket = fsockopen($host, $port, $errnum, $errstr, $timeout);
    if (!is_resource($socket))
    {
    exit("Cannot connect: " . $errnum . " " . $errstr);
    }
    else
    {
    fputs($socket, $message);
    }
    fclose($socket);

This script is called from my phone and connects to the socket server listening on my laptop.  The code for the corresponding socket server follows:

      use strict;
      use IO::Socket;
      use Net::hostent;
      
      my $PORT = 7890;
      my $IP = '192.168.0.1';
      
      my $serverSocket = IO::Socket::INET->new(
          Proto => 'tcp',
          LocalHost => $IP,
          LocalPort => $PORT,
          Listen => SOMAXCONN,
          Reuse => 1,
      ) or die("Cannot create socket: $!\n");
      
      while (my $clientSocket = $serverSocket->accept())
      {
          $clientSocket->autoflush(1);
          while (<$clientSocket>)
          {
              `/path/to/tk/script/showMessage.pl "$_"`;
          }
          close($clientSocket);
      }

This Perl script listens in the background for incoming connections and passes any data it receives to a Perl TK script that displays this data in the form of a simple window on display 0:0.  Here's the code for th Perl Tk srcript:

      use strict;
      use Tk;
      use Tk::Font;
      
      my $message = $ARGV[0];
      
      my $mainWindow = MainWindow->new();
      $mainWindow->minsize(qw(500 200));
      $mainWindow->title("Incoming Call");
      $mainWindow->configure(-background => 'white');
      
      my $font = $mainWindow->Font(
          -family => 'Arial',
          -size => '24',
      );
      
      my $acceptButton = $mainWindow->Button(
          -text => $message,
          -background => 'red',
          -command => \&amp;exit,
          -foreground => 'white',
          -font => $font,
      );
      
      $acceptButton->pack(
          -side => 'bottom',
          -expand => 1,
          -fill => 'both'
      );
      
      $mainWindow->withdraw();
      $mainWindow->update();
      my $winXPos = int(($mainWindow->screenwidth - $mainWindow->width) / 2);
      my $winYPos = int(($mainWindow->screenheight - $mainWindow->height) / 2);
      $mainWindow->geometry("+$winXPos+$winYPos");
      $mainWindow->deiconify();
      
      MainLoop();

There's no doubt about it, this combination of scripts is crude, insecure, and really more of a proof of concept.  Nonetheless, it serves my purposes and hopefully can tidy it up as time allows.
