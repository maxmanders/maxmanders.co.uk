---
title: Security, Passwords and Password Managers
layout: post
---

In this post, I want to talk about staying secure online. This is a less technical post that those I often write. It's
aimed at my family and non-technical friends, who perhaps don't appreciate why security online is so important; why
choosing unique, strong passwords is important; and why password managers are for everyone, and not just
socially-awkward sysadmin code monkeys like me. If you think *"&hellip; nobody's going to be trying to hack my Gmail
account &hellip;"* then read on!

<!--more-->

A lot of people make the same mistake when it comes to their online security: reusing the same password (or a similar
password) with all of their online accounts. To keep your accounts and your data safe online, you should use long,
complicated, and unique passwords for every account. But how is the average person meant to remember all of those
passwords?  The short answer is you don't, you let a password manager do that for you. I use a password manager, and
other than a few special cases, I couldn't tell you what any of my passwords are!  But what I could tell you is that
most of them are over 16 characters long (that's a letter, a number, or some other punctuation symbol), don't actually
make any real words, and are a combination of lower- and upper-case letters, numbers and other symbols.

I think there are a few misconceptions about the various security breaches you may have heard about. It's possible that
someone close to you may want to compromise e.g. your Gmail account. For that reason, you should make sure any
passwords you use don't contain words or phrases that mean something to you: your pet's name; your spouse's birthday or
your wedding anniversary; your mother's maiden name etc. However, while that's generally good advice, it's actually
incredibly unlikely that someone close to you would try to to compromise your online security. In fact, it's incredibly
unlikely that anybody would specifically target *you*!

What is far more likely to happen is that a computer program is written or acquired by some miscreant, or ill-informed
*script kiddy* , and an attack is orchestrated against a site from a hijacked computer somewhere. The details of how
that may happen are outside the scope of this post. In this case the attacker may simply automate the process of trying
to log in to some site by cycling through combinations of words, making incremental *guesses* at user names and
passwords. This sort of attack is often referred to as *brute force*: there's no sophistication or informed guesswork
involved, it's just a matter of trial and error. Crucial to avoiding being the victim of this sort of random attack is
the use of long, complicated and unique passwords. Attackers often use dictionaries of words. The longer the password,
the more *expensive* in terms of time and computer resources it is to *guess* the password. Avoiding common dictionary
words makes this even harder because whole sections of a password can't be tried.

Great, so armed with this information, why not just come up with a really long, complicated password that you can
remember, and use that with all of your online accounts?  If an attacker has compromised one account, they can
potentially compromise others: it doesn't matter how complicated your password is if you use the same password
everywhere, and it's been compromised. As I said before, an attacker probably hasn't targeted you specifically, but if
they have managed to find e.g. an email address and password that gives them access to an account, they'll likely try to
use those same credentials on other popular web sites.

So in conclusion, we need long, complicated *and* unique passwords for all of your online accounts. So we need a tool
to store those passwords securely for us, and ideally, to generate those passwords. If we don't need to memorise such
strong passwords, why not generate password that aren't particularly memorable!  That's where a password manager comes
in. There are quite a few of them on the market: some of them free and open-source, some of them come with a small
financial outlay. The ones you should consider have a few common characteristics though.

* a master password is used to unlock your password *vault*
* your password vault is *encrypted* with that master password; without the master
password, the *vault* is just meaningless gibberish
* the password manager can generate passwords of different lengths and complexity
* the password manager can auto-fill websites once unlocked
* the password *vault* can be shared with your other devices like your phone or tablet

But isn't this putting all my eggs in one basket?  Sure, you're securing all of your complicated, unique passwords with
a single password. But that single password, the one you remember, can and should be very complex, but you only need
remember that one password. You should also change that password regularly to minimise the risk of your *vault* being
compromised. Your password *vault* is also not sitting there, publicly available as a popular website that would be
targeted by attackers. You might use an online service to sync your encrypted password database between devices, but
that service doesn't know your master password. Attackers are far more likely to compromise any number of websites than
your password vault.

There are a lot of password managers out there, but I'd recommend [1Password](https://agilebits.com/onepassword) for OSX
and iOS devices; KeePass for Windows, or KeePassX for Linux (and OSX). There are also web based services such as
[LastPass](http://www.lastpass.com) or [Dashlane](https://www.dashlane.com/)

You can also further enhance your security online by taking advantage of Multi Factor Authentication (MFA) or Two Factor
Authentication (2FA) on services that offer this feature. The idea of MFA is to increase security by requiring two
pieces of information to sign in (in addition to a username): something you know, and something you have. In this case
the thing you know, is your password. The thing you *have* is a special time-limited code that is generated, on a
per-account basis, by an application on your phone. Such applications are Google Authenticator and Authy. When you
enable MFA, you often scan a QR code with your phone. This code (which changes usually every minute) allows your phone
to synchronise some secret bits of information with the website you're accessing. From that point forward, your phone
can generate codes that the website you're accessing can check, in addition to your password. If an attacker
compromised your password, it would be very difficult for them to also compromise your phone and the time-limited codes
on it.

So as part of your New Year's Resolutions, please resolve to be more security conscious online. Start using a password
manager. Start changing all your passwords to something complex and unique, for each account you use. And where
possible, use MFA!
