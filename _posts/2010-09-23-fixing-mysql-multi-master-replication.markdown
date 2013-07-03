--- 
tags: []

date: 2010-09-23 22:44:25 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/?p=256
author: maxmanders
wordpress_id: 256
published: true
layout: post
categories: 
- MySQL
title: Fixing MySQL Multi-Master Replication
comments: []

excerpt: I've had some exposure to database replication through PostgreSQL/Slony.  I'm reasonably familiar with master/slave replication but in the last few days I've had to get my hands dirty and grok multi-master replication with MySQL, specifically with two MySQL servers in master<->master mode.  Although conceptually it's not a significant leap from simple master/slave replication the added layer of replication in both directions made my brain melt a little bit at first.  Now that I've got my head around as much as I need to, I'm writing this as a gentle reminder should replication screw up again!
author_email: max@maxmanders.co.uk
---
I've had some exposure to database replication through PostgreSQL/Slony.  I'm reasonably familiar with master/slave replication but in the last few days I've had to get my hands dirty and grok multi-master replication with MySQL, specifically with two MySQL servers in master<->master mode.  Although conceptually it's not a significant leap from simple master/slave replication the added layer of replication in both directions made my brain melt a little bit at first.  Now that I've got my head around as much as I need to, I'm writing this as a gentle reminder should replication screw up again!<!--more-->

In master/slave replication, one server can be thought of as authoritative; all writes are done on the master and these writes are replicated to the slave.  This replication model shouldn't be thought of as a backup solution as both <code>DELETE</code>s as well as <code>INSERT</code>s and <code>UPDATE</code>s are replicated.  You should have a proper backup solution in place.  Also, I'm not going to be discussing how to set up MySQL to replicate in multi-master mode.

With master<->master replication, replication happens in both directions.  If we have two servers - server_a and server_b - both servers are considered masters and authoritative.  server_b is considered slave with respect to server_a, and server_a is considered slave with respect to server_b.  Every write that happens on the server is logged in what are called the binary log files.  The master server then replicates these writes to it's slave, where the statements are effectively <em>replayed</em> to reflect the change on the slave.  To keep everything in order, each master keeps track of the current binary logfile being written to, and an integer representing the last statement that was executed against it.  Each slave also keeps track of this data, and when things are running smoothly, the details on the master match that of it's slave.  However, sometimes things go wrong...

The following instructions are meant only for a development environment where absolute data integrity isn't crucial - very hacky; the priority is to get the replication going again.  Depending on our set up, we need to pick one of the masters to consider authoritative; restoring replication requires that both master databases be identical.

First we need to make sure replication is stopped on both servers

      mysql>STOP SLAVE;

Next we need to get a dump of the database(s) from one of the servers, <code>scp</code> it to the other server and import it.

      mysqldump -u root --all-databases --lock-all-tables --master-data >dbdump.db

The <em>--master-data</em> switch <em>should</em> make sure that sequence numbers are in sync so both servers know where to start sync'ing from.

Now we pick one server and run

      myqsl> SHOW SLAVE STATUS\G

and on the other server we run

      mysql> SHOW MASTER STATUS;

If everything is okay, the master status file and position number should match those of the slave.  Now we run the same commands but swapping which servers we run them on.  Again, the master status file and position number should match those of the slave.

If there are mismatches, we need to fix this by running on the master server

      mysql>CHANGE MASTER to master_log_file='file_from_slave',master_log_pos='log_position_from_slave';

And vice-versa on the other master server if necessary.  We can then cross our fingers and start replication again by running the following on each server.

      mysql> START SLAVE;

To test everything is working make an update on each server, and it should appear on the other server!

<em>Disclaimer: This is probably in no way accurate and is purely here to jog my memory and that of anyone else in multi-master replication hell.  There are probably glaring omissions in the above, and this information should in no way EVER EVER EVER be used in a production environment - that's what the clever proper sysadmins are for! You have been warned, here be dragons etc.</em>
