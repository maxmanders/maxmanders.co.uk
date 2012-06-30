--- 
tags: []

date: 2012-01-16 21:58:26 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=490
author: maxmanders
wordpress_id: 490
published: true
layout: post
categories: 
- General
title: Recovery Disk My Backside - Another Reason I Use Linux
comments: 
- date: Mon Jan 16 22:39:00 +0000 2012
  date_gmt: Mon Jan 16 22:39:00 +0000 2012
  author_url: ""
  author: Rickymanders
  content: |
    Max, if you have a root around in the recovery disk/partition, you may be able to find a *.sif file or *.txt file with the product id/key details in it - I have managed to recover a workable product key this way before from a PE style install. If not, do you have a disk image backup that you can go back to, and use something like Hirens boot cd to recover the product id that way? 

  author_email: rickymanders@hotmail.com
  id: 34631
- date: Mon Jan 16 22:40:00 +0000 2012
  date_gmt: Mon Jan 16 22:40:00 +0000 2012
  author_url: ""
  author: Rickymanders
  content: |
    the file may be called unattended.txt / sif 

  author_email: rickymanders@hotmail.com
  id: 34632
- date: Mon Jan 16 22:46:00 +0000 2012
  date_gmt: Mon Jan 16 22:46:00 +0000 2012
  author_url: ""
  author: ""
  content: My plan was to use Magic Jellybean Keyfinder to recover the key from whatever semblance of a crap but bootable system I could cobble together.  Unfortunately frustration and fatigue got to me and I just reinstalled Ubuntu.  I'll probably try again.  It looks like the disks recreate a partition, then the partition boots to do the actual restore.  In theory, I could probably to it on a VM first and investigate the VM.
  author_email: max@maxmanders.co.uk
  id: 34633
- date: Sat Jan 28 11:22:00 +0000 2012
  date_gmt: Sat Jan 28 11:22:00 +0000 2012
  author_url: http://twitter.com/dnwood
  author: Denise Wood
  content: "Yeah, I've had the problem of the license number on the back wearing away on me, so the first thing I did when I unboxed my new machine was take a picture of it. My old Dell laptop had both a Windows license number and a laptop serial number -- and I remember calling Dell and giving them the serial number, and they sent me the physical Windows installation discs.\n\n\
    It is a pain, though. "
  author_email: ""
  id: 34634
- date: Sat Jan 28 11:29:00 +0000 2012
  date_gmt: Sat Jan 28 11:29:00 +0000 2012
  author_url: ""
  author: ""
  content: I'm happy enough with Ubuntu 10.10 on it for now, and hopefully when I sell it I'll find a buyer who likes Ubuntu or doesn't mind not having Windows!  Definitely taking a photo when I get my next laptop though!
  author_email: max@maxmanders.co.uk
  id: 34635
excerpt: I had planned on selling on my current laptop to invest in something more future proof. I very much like my HP Pavillion DV6; but the build quality isn't as good as I'd like, and although the ATI Radeon graphics would be great if I was a Windows 7 user, Nvidia seems to be better supported as Ubuntu continues to evolve, and since Ubuntu is my Linux distribution of choice, it makes sense for me to opt for something with Nvidia graphics. I'd hoped to get something around the &pound;300 mark as the laptop is in great condition and is very well spec'd. However, any potential buyer would more than likely want the laptop restored to factory settings, with Windows 7 installed. And so begins a hellish day...
author_email: max@maxmanders.co.uk
---
I had planned on selling on my current laptop to invest in something more future proof. I very much like my HP Pavillion DV6; but the build quality isn't as good as I'd like, and although the ATI Radeon graphics would be great if I was a Windows 7 user, Nvidia seems to be better supported as Ubuntu continues to evolve, and since Ubuntu is my Linux distribution of choice, it makes sense for me to opt for something with Nvidia graphics. I'd hoped to get something around the &pound;300 mark as the laptop is in great condition and is very well spec'd. However, any potential buyer would more than likely want the laptop restored to factory settings, with Windows 7 installed. And so begins a hellish day...<!--more-->

I had restored the laptop in this manner at least once in the past, I can't recall the reason, but I am sure I'd done it.&nbsp; As with most laptops bought these days, you don't get a proper Windows 7 installation disk, instead you get some form of cut-down shonky recovery solution.&nbsp; In my case, this was a combination of a recover partition and an HP utility that could be run from Windows to create recovery disks from that partition.&nbsp; I have since discovered (too late) that the recovery can be started from within Windows without the need to reboot with the first of the recovery disks inserted.&nbsp; This option makes the disks redundant, unless you're in my position where you no longer have a bootable Windows installation.

I followed what I thought to be the appropriate procedure of booting from the first disk, following the instructions and eventually being told to remove disk three and restart the machine.&nbsp; When the machine restarted, some sort of Windows 7 had started, with a full screen window titled 'Restoration Incomplete'.&nbsp; I was unable to start the task manager or launch any other applications to investigate further.

The window had three buttons: 'Save Log', 'View Details' and 'Retry'.&nbsp; Clicking 'Save Log' saved a password-protected zip file to the first available USB storage device -- I wasn't given an option of where I'd like to save the file.&nbsp; I also had no idea why the file was password-protected, nor what the password was.

The next option, 'View Details', appeared to do nothing.&nbsp; The final 'Retry' button asked me to re-insert the first disk.&nbsp; Upon doing so, the disk was ejected and the message was redisplayed.&nbsp; I tried the restore three times to be sure the problem was consistent and not a fluke.&nbsp; Having booted from an Ubuntu disk, I used cfdisk and gparted to find out what had actually been done to the disk after the apparent failure. &nbsp;The previously pristine disk now had three partitions, one of which was flagged as bootable. &nbsp;Mounting this partition revealed a file that was named so as to suggest it was some sort of error flag. &nbsp;I deleted the file and rebooted.

I still got the error, but I was also able to start the task manager. &nbsp;I killed the process responsible for the recovery error window, and the setup continued as hoped. &nbsp;A progress window suggested files were being installed, and at one point I even caught a glimpse of a Windows 7 task bar! &nbsp;However, close to the end, the error window appeared again and I was denied access to the task manager. &nbsp;Subsequent attempts at rebooting consistently failed with the same error.

I tried calling HP to see if they could offer any help. &nbsp;The representative I spoke to suggested that I'd need to create the recovery disks -- the ones I had already explained that I had created. &nbsp;I told the representative that I had previously used these disks without error, so clearly the HP utility that was originally run didn't create faulty disks. &nbsp;However, now absent a working Windows 7 installation I couldn't try again. &nbsp;The only option that the HP representative offered me was to pay for them to send me a set of the same disks for my particular machine, at a cost of &pound;50 and with no guarantee that they would work. &nbsp;No thanks!

Microsoft next. &nbsp;The license sticker on the bottom of my laptop has worn away, and perhaps I should have noted the number down somewhere. &nbsp;I tried calling Microsoft to see if they could tell me my license number given a laptop model and serial number. &nbsp;I was told that nobody kept that information, and that in my particular case I'd have no option but to buy a new copy.

So, in summary a laptop that I purchased came pre-installed with an operating system and a method for restoring that operating system to its original state; &nbsp;however, that restoration process isn't fit for purpose. &nbsp;Despite Windows 7 -- and in my mind that ability to rebuild the laptop to it's original state -- being included in the cost of the laptop, I now have to fork out a third of my anticipated sale price to have a shot of selling.

This post isn't meant to be pro-Linux rhetoric or a piece of Windows- or Microsoft-bashing, but it highlights quite nicely one of the non-technical reasons I choose Linux over Windows. &nbsp;I feel utterly frustrated having no recourse, no way to reinstall Windows. &nbsp;Maybe I should pirate a copy?
