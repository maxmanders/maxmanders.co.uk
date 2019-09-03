--- 
title: SSMTP Local MTA Using Google Apps Account
layout: post
---

While there are plenty of MTAs out there, I find it quite handy to have SSMTP installed locally; it's quick to install
and configure and lacks some of the overhead of a more *enterprise* MTA such as Sendmail, Postfix, Exim etc. The
following assumes you have a "Google Apps for Domains" user account, e.g. `ssmtp_user@domain.com`, through which you
will relay all email. Additionally, the steps below work on Ubuntu 10.10, similar steps should work on other
distributions.

<!--more-->

### Install SSMTP

```bash
sudo apt-get install ssmtp
```

### Edit configuration in `/etc/ssmtp/ssmtp.conf`

Backup the original first

```bash
sudo cp /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.out
```

### Truncate the file and add the following

```
mailhub=smtp.gmail.com:587
hostname=ssmtp_user@domain.com
root=ssmtp_user@domain.com
AuthUser=ssmtp_user@domain.com
AuthPass=<ssmtp_user_password>
UseSTARTTLS=yes
UseTLS=yes
FromLineOverride=yes
```

### Edit revaliases map in `/etc/ssmtp/revaliases.conf`

Add a line for each local user who should be able to send email

```
root:smtp_user@domain.com:smtp.gmail.com:587
max:smtp_user@domain.com:smtp.gmail.com:587
```

### Send email

You should now be able to send email, e.g. from the shell using

```bash
echo "Testing" | mail -s "Test Email" someone@example.com
```
