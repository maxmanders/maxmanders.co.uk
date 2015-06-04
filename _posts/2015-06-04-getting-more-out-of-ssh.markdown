---
layout: post
title: "Getting More Out Of SSH"
date: 2015-06-04 15:52:02 +0100
published: true
author: Max Manders
tags:
categories:
- linux
---
If you've been working with Linux servers for any length of time  then you've used SSH to connect to a server. Though the way you use SSH and the features you use may vary, SSH is incredibly powerful and has a lot of features the average user may not be aware of, or use.  I don't want to say this is a post about _power user_ features, or a list of hidden tips and tricks; the more you use something, the more you understand it, and more efficiently use it.  This post is just a collection of features I use that others I've seen don't, and may prove useful to others. <!--more-->

## Getting Started Fundamentals
The first few sections below outline how to generate a key pair and give a high level overview of what public key cryptography means in this context.

### Using Keys
I’d imagine you probably already use keys rather than plain password authentication.  If you don’t, you should.  And here’s how.

First, you need to generate a new key pair.  A key pair consists of a public key and a private key.  The private key stays on your client machine.  The public key is added to any server that you wish to access.  A passphrase is used to secure the key pair, but successful authentication also depends upon using that password together with your local private key and the presence of your public key on the target server.

To generate your key pair, you can run

{% highlight bash %}
    $ ssh-keygen -t rsa
{% endhighlight %}

This will create two files, by default, in your `~/.ssh/` directory.  You can change the location by adding a `-f <pathname>` to the `ssh-keygen` command above.  This will create `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub` as your private and public keys respectively.

Now, you need to append the contents of `~/.ssh/id_rsa.pub` to `~/.ssh/authorized_keys` on the remote server.

{% highlight bash %}
    $ cat /.ssh/id_rsa.pub | ssh user@remotehost 'cat >> /.ssh/authorized_keys'
{% endhighlight %}

Now, when you try to connect to the remote host, you won’t be prompted for your password.  You may be prompted for the passphrase to unlock the key, but you should only need to do that once (or e.g. whenever you restart your computer).

### SSH Agent
Most Operating Systems allow you to use an _agent_ program with SSH.  On Linux systems, this is typically `ssh-agent`.  On windows, you can use Pageant with Putty.  An SSH agent securely stored unlocked private keys in memory for the duration of a session, to avoid the need to always specify commonly used keys when using SSH.  Note that SSH will attempt each key stored in the agent.  If all of the keys are exhausted unsuccessfully the SSH server may return an authentication failure to avoid brute force attacks with many different keys.

### Private Keys Are Private
By way of an analogy, imagine you are Alice, and Bob wants to allow you access to his server.  Key based authentication is like opening a door that’s padlocked.  Bob could send Alice a key to unlock the padlock and gain access (a private key), but that means the private key is out in the open while it’s being sent, for any nefarious party to grab.  Instead, imagine the door can be unlocked by Alice giving Bob her padlock (the public key); and that anybody with a key to their own padlock can unlock the door.  In this way, you can give padlocks (public keys) to anybody who wants to give you access to their server, but you keep the key (private key) to yourself.

For this reason, the private key should be kept very secure.  For all intents and purposes, think of it as your password.  You don’t just hand that out over email, right!

### Diagnosing Connection Issues
If you’re having trouble connecting to a remote machine, and you’re not sure why, then you can increase the verbosity of the SSH command line.  By default, adding `-v` to your SSH command will make things _a bit more verbose_.  You can get ever more verbose output with `-vv` or `-vvv`.  The verbose output can often quickly point you in the right direction.

### Every Day Usage
Connect to `remotehost` as the same user as your local user, optionally using non-standard port `port`.

{% highlight bash %}
    $ ssh remotehost [-p port]
{% endhighlight %}

Connect to `remotehost` as user `user`, optionally using non-standard port `port`.

{% highlight bash %}
    $ ssh user@remotehost [-p port]
{% endhighlight %}

Connect to `remotehost` as the same user as your local user, using the private key `/path/to/private-key`, optionally using non-standard port `port`.

{% highlight bash %}
    $ ssh -i /path/to/private-key remotehost [-p port]
{% endhighlight %}

Connect to ‘remotest’ as the user `user`, using the private key `/path/to/private-key`, optionally using the non-standard port `port`.

{% highlight bash %}
    $ ssh -i /path/to/private-key user@remotehost [-p port]
{% endhighlight %}

Note that if you don’t specify a private key, prior to attempting password authentication, an attempt will be made to use key-based authentication using any keys in your `ssh-agent`.  This will typically contain any default keys such as `id_rsa` or `id_dsa`.  You may need to unlock the key the first time you use it in a given session.

## Tunnelling
SSH can be used for so much more than just connecting to a shell session on a remote server.  If you have access to a remote server, you can do all manner of useful things involving port forwarding and tunnelling.

### Local Port Forwarding
If you need access to a port on a remote server that isn’t publicly exposed, for example a remote MySQL server that’s only listening to localhost, you can forward a local port to a remote port.

{% highlight bash %}
    $ ssh -f -N -L 4406:127.0.0.1:3306 user@remotehost
{% endhighlight %}

This command will forward the local port 4406 to the remote port 3306.  The `-f` flag puts the SSH command into the background; the `-N` option makes sure that no remote commands are executed; the `-L` flag is used to forward a local port to a port on a remote host, rather than forwarding traffic from a remote port to the local host.

Note that you can also use other options, as described earlier, such as specifying a private key with `-i` or a non-standard port with `-p`.

You could use the same local and remote port, provided you don’t have a local MySQL server that’s already listening on that port.

Note that you don’t have to use localhost.  In fact, you can forward any service that the remote machine you have access to, can see.  If the MySQL database was hosted on a completely private machine that `remotehost` can route to and access, called `db-remotehost`, you could do the following.

{% highlight bash %}
    $ ssh -f -N -L 4406:db-remotehost:3306 user@remotehost
{% endhighlight %}

### Remote Port Forwarding
Remote forwarding is useful in situations where you and another party both have access to a common machine, and you would like to use that machine to offer access to the other party, to a service running on your local machine.

In this example, you might have a local web server listening on port 8080, and you’d like to allow a third part to access that local web server.  You’d like the third party to be able to browse to the IP address of the common shared server, on port 9090, and have them access your local web server on port 8080.  To do so, you’d use a command like the following.

{% highlight bash %}
    $ ssh -f -N -R 9090:localhost:8080 user@remotehost
{% endhighlight %}

Note that in this example, we use the `-R` flag for remote forwarding, rather than the `-L` flag we used earlier.  Also note that the order of the ports is reversed when compared to the earlier example: the remote port comes first, and the local port comes second.

In order for this to work, you also need to enable the `GatewayPorts` option on the SSH daemon on the remote host.  You’ll also need to ensure that any firewall running on the remote host permits access to port 9090.

## SSH Config
All of the examples given thus far should prove useful, but may become a pain to use regularly, especially if you are administering a large number of Linux servers.  To ease this pain, you can use an SSH config file to define common host aliases and sets of options.  On a per-user basis, the config file is typically located at `~/.ssh/config`.

The file is arranged in terms of a series of `Host` blocks.  Each definition continues until the next `Host` block.  Wildcards can also be used to broaden the scope of a match.  The configuration file is parsed from top to bottom, looking for hosts that match the host used in the SSH command you run.  The matching doesn’t immediately stop at the first match.  Any later matches in the file can add to options previously defined, but only for options that have not yet been defined earlier.

If we want to connect as user `bob` to `remotehost1.example.com` on port 2222 with a private key named `bob-key`, we could use a command line such as the following:

{% highlight bash %}
    $ ssh -i /path/to/bob-key -p 2222 bob@remotehost1.example.com
{% endhighlight %}

We could also use the SSH config option names rather than the SSH command line options:

{% highlight bash %}
    ssh -o "IdentityFile /path/to/bob-key" -o "Port 2222" -o "User bob" -o "HostName remotehost1.example.com"
{% endhighlight %}

But this would get pretty tiresome to type all the time.  It would be nice if we could instead just type `ssh remotehost1`.  We can achieve this by adding the following block to `~/.ssh/config`.

{% highlight bash %}
    Host remotehost1
      IdentityFile /path/to/bob-key
      Port 2222
      User bob
      HostName remotehost1.example.com
{% endhighlight %}

Because of the ordering described earlier, you can construct your file with less specific, shared options, toward the end of the file.  You should think of such entries as “catch all” rather than “default” and always ensure they come last.  For example, I use the following sensible options that will apply to all connections, unless override with more specific options earlier in the file.

{% highlight bash %}
    Host *
      identitiesonly yes
      cipher arcfour
      compression yes
      serveraliveinterval 60
      gssapiauthentication no
{% endhighlight %}

### Proxy Commands
You may require access to a large number of private servers, all of which can be accessed via an intermediary bastion host.  However, you might not want to send your agent everywhere.  In this case, you can use a `ProxyCommand` option in your SSH config file.  In the example below, we use the netcat in a `ProxyCommand` to effectively tunnel onward to the target private host.

With this in place, we can connect to e.g. `db.private.example.com` or `www2.private.example.com` and SSH will transparently connect firstly to the bastion host, and then set up a netcat tunnel to pass the SSH connection through to the destination host.

{% highlight bash %}
    Host bastion.example.com
      ProxyCommand none
    Host *.private.example.com
      ProxyCommand ssh bastion.example.com nc -q0 %h %p
{% endhighlight %}

## Miscellaneous

### Removing A Bad Host
If you try to connect to a host, and the server signature differs to that recorded in the known hosts file, you may need to remove the offending signature from the known hosts file.  You should do this with caution, and only when you know the server you are connecting to is legitimate: for example if you’ve relaunched an AWS EC2 instance with the same hostname.

You can either use `ssh-keygen`:

{% highlight bash %}
    ssh-keygen -R hostname
{% endhighlight %}

Or you can use `sed`, since the error message will give the line number of the offending known hosts entry (line 25 in this example):

{% highlight bash %}
    sed -i '25d' ~/.ssh/known_hosts
{% endhighlight %}

### Forcing Password Login
If you are working with a host that you know only accepts password authentication, and you want to quickly avoid the overhead of trying keys, you can use a command line such as the following.

{% highlight bash %}
    ssh -o "PreferredAuthentications password" -o "PubkeyAuthentication no" user@remotehost
{% endhighlight %}

### Skipping Known Hosts Checking
If you work with e.g. Amazon Web Services, or otherwise interact with a lot of short-lived and disposable or ephemeral servers, you may want to skip checking the known hosts file, since you expect server signatures to change for a given host quite frequently.  This should be used with caution, and you wouldn’t want to globally  take this step for security reasons.

{% highlight bash %}
    $ ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null" user@remotehost
{% endhighlight %}

This command will automatically add the host to the known hosts file, but also use /dev/null as that file.

### Check If Host Key Exists
You can check for the presence of a given host key in your known hosts file with the following:

{% highlight bash %}
    $ ssh-keygen -F hostname-or-ip
{% endhighlight %}

### Diff Local And Remote
You can quickly diff a remote file with your local copy with either of the following two examples.

{% highlight bash %}
    $ ssh user@remotehost "cat remote_file.txt" | diff - remote_file.txt
{% endhighlight %}

{% highlight bash %}
    $ diff local_file.txt <$(ssh user@remotehost 'cat remote_file.txt')
{% endhighlight %}

### Pseudo TTY Allocation
You’ll find some commands, such as `sudo`, will give you an error when you try to run the command on a remote server via SSH.  You may see an error about being unable to allocate a TTY.  To overcome this issue, you use the `-t` flag to force allocation of a pseudo-tty.

{% highlight bash %}
    $ ssh -t user@remotehost sudo cat /etc/passwd
{% endhighlight %}

### Skipping Lastlog
Similarly to the above example, you can disable allocation of a pseudo-tty with the `-T` flag.  This will mean your session doesn’t appear in the output of `who` or `lastlog`.

{% highlight bash %}
    $ ssh -T user@remotehost
{% endhighlight %}

### SSH Escape Sequences
You’ve no doubt used telnet before, to diagnose network connectivity issues; to do some basic interaction with a web serve or an MTA etc.  If you have, you’ll probably be aware of the `^]` escape sequence to hang up the session and drop you to the telnet shell.  From there you can `^d` to get back to your regular shell.  SSH comes with similar functionality via the `~` escape sequence.  If you’re connected to a machine with SSH, you can type `~?<enter>` to see a list of supported options.  You’ll most often use `~.` to kill a hung SSH session.

{% highlight bash %}
    Supported escape sequences:
    ~.   - terminate connection (and any multiplexed sessions)
    ~B   - send a BREAK to the remote system
    ~C   - open a command line
    ~R   - request rekey
    ~V/v - decrease/increase verbosity (LogLevel)
    ~^Z  - suspend ssh
    ~#   - list forwarded connections
    ~&   - background ssh (when waiting for connections to terminate)
    ~?   - this message
    ~~  - send the escape character by typing it twice
{% endhighlight bash %}

