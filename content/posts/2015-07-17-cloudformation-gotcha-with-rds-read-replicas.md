---
title: CloudFormation Gotcha With RDS Read Replicas
date: 2015-07-17
---

I've spent more time than I'd like this week being perplexed by spurious behaviour in creating a replicated MySQL
environment in RDS, with CloudFormation.  RDS supports creating up to five MySQL read-replicas to slave off of a running
MySQL master.  Configuring this using the web console involves selecting a master RDS instance and selecting the option
to create a read-replica.  Before the read-replica is created, a configuration page allows various parameters to be
reviewed and updated.  By default, key parameters such as the size and storage class of the attached EBS volumes are
inherited from the master.

TL;DR -- always explicitly specify PIOPS for both master and read-replica RDS instances when using CloudFormation.  If
you don't, you're going to have a bad time.

Creating a similar environment from scratch with CloudFormation involves describing both the master RDS instance and up
to five slave instances.  Crucially, certain CloudFormation properties should not be specified when creating the slaves;
rather a reference is made to the master instance from which the read-replicas will slave.

If you were to omit properties for the size and storage class of the slave EBS volume you might expect that, as with the
web console, those parameters would be inherited from the master instance.  You'd have that assumption further validated
when you reviewed the pending resources being created in the web console.  You would notice that the same values set for
the master instance storage are set for the slave.  Unfortunately, this is a bit of misdirection, and once the slaves
had launched and finished replicating from the master, you'd see those storage options change to a default of magnetic
EBS storage!

If you were launching a modest CloudFormation stack with a small EBS volume, without restoring from a snapshot, you'd
probably notice your mistake quite quickly.  However, if like me, you were creating each instance with 2TB of 20K PIOPS
provisioned SSD EBS storage, you'd run in to the slaves timing out and failing to stabilise after many hours, despite
all event logs indicating the contrary.  In my case, the event logs clearly showed that the master had been backed up;
that backup had been used to seed the slaves; and the slaves had successfully restored from that backup and resumed
replication.  However the slaves remained in a *modifying* state for hours, and eventually the stack rolled back because
the slaves failed to stabilise.

Despite this, I could connect to all of the nodes, and verify that replication was working as expected.  I created a
database on the master and watched that statement replicate to the slaves.  I streamed the binary logs from the master
and reviewed them for evidence of something going awry, but no such evidence was forthcoming.

Eventually, I resorted to raising a case with AWS Enterprise Support.  After some back and forth, and a thorough review
of both the RDS instances and the CloudFormation template, I finally had my answer.

By omitting a PIOPS property on the RDS slave instances, the slaves were in fact launched with 2TB of incredibly poorly
performing magnetic EBS storage, despite the web console and CLI tools claiming otherwise.  Had I waited long enough,
and had the operation not timed out, the web console would eventually have been updated to reflect this, rather than the
2TB 20K PIOPS volumes I had expected were inherited from the master instance.  AWS confirmed that after restoring, the
slave volumes were then converted to magnetic EBS storage by effectively creating a new EBS volume from a snapshot.
This process took so long that CloudFormation didn't consider the stack stable within some alloted period of time, and
rolled back.

So, if you're ever provisioning RDS read-replicas with CloudFormation.  Always remember to explicitly specify PIOPS for
both the master instance and any slave instances.

