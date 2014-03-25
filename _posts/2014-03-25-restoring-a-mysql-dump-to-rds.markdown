--- 
date: 2014-03-25
layout: post
title: Restoring a MySQL Dump to RDS
author: Max Manders
categories:
- aws
---
I've spent some of today migrating a MySQL database instance into RDS from another RDS instance in
a separate AWS account as part of a larger piece of work.  However, there were a few
gotchas that caught me out, so it's worth keeping the following in mind if you're having
issues.<!--more-->

To avoid needing to keep typing the MySQL password, it's a good idea to

{% highlight bash %}
export MYSQL_PWD=<your password>
{% endhighlight %}

A first attempt might be a standard `mysqldump` command such as the following:

{% highlight bash %}
mysqldump  -h <host> -uroot --all-databases > dump.sql
{% endhighlight %}

However, in this case the database will contain the `mysql` schema, and perhaps others,
which you probably won't need.  You can fix that by being explicit about which tables you
are not interested in:

{% highlight bash %}
DATABASE_LIST=$(mysql -NBe 'show schemas' -h <host> -uroot | 
  egrep -v "information_schema|innodb|mysql|performance_schema" | 
  tr "\n" " ");
mysqldump  -h <host> -uroot --databases ${DATABASE_LIST} > dump.sql
{% endhighlight %}

This is heading in the right direction, but when you restore from this backup you might
see an error similar to the one below:

        Got error: 1142: SELECT,LOCK TABL command denied to user ‘root’@'localhost’
        for table ‘cond_instances’ when using LOCK TABLE

So we need to add the `--skip-lock-tables` option.

The next problem came when trying to restore the various triggers, functions and stored
procedures in the database.  I should RTFM more, but by default triggers are included in a
mysqldump, but stored procedures are not.  This needs to be made explicit with something
like:

{% highlight bash %}
mysqldump  -h <host> -uroot --skip-lock-tables 
--databases ${DATABASE_LIST} --add-drop-database --triggers --routines --events 
   > dump.sql
{% endhighlight %}

Great, that should be everything, right?  Wrong.  MySQL requires certain elevated
permissions to perform operations such as creating stored procedures.  RDS doesn't permit
the granting of the SUPER privilege.  Some of this can be mitigated by adding the
following to your RDS Database Parameter Group:

        log_bin_trust_function_creators = 1

But that's only half the battle.  The backup file actually contains stored procedure
definitions.  These definitions include the user who the stored procedure should be
created by, the _DEFINER_.  Since `mysqldump` doesn't handle migrating users and grants,
the _DEFINER_ doesn't exist at the time of restoring, so an error is raised.  We can
remove the _DEFINER_ using _sed_ or _Perl_ and create the stored procedure with the user
who is performing the restore.

{% highlight bash %}
perl -pe 's/\sDEFINER=`[^`]+`@`[^`]+`//' < dump.sql > dump.fixed.sql
{% endhighlight %}

With these adjustments, the backup should restore without error.  Of course, the users and
their permissions are missing.

We can get a list of all user and host combinations with

{% highlight bash %}
mysql -h <host> -uroot -B -N -e "select user, host FROM user” mysql
{% endhighlight %}

Then for each of these combinations, we can extract the grants and append them to a file
for later import into MySQL:

{% highlight bash %}
mysql -h <host> -uroot -B -N -e "SHOW GRANTS FOR ‘<user>’@‘<host>'" >> users.sql
{% endhighlight %}

Hope this proves useful to others, but it'll certainly be a brain dump I'll refer to in
the future.
