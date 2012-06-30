--- 
tags: []

date: 2007-02-21 10:12:50 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/blog/technology/openid-decentralised-user-centric-idenity-management/
author: maxmanders
wordpress_id: 33
published: true
layout: post
categories: 
- Technology
- Development
- OpenID
title: "OpenID: Decentralised User-Centric Identity Management"
comments: []

excerpt: |-
  We sign up to more and more services online every day.  This often involves remembering multiple, often similar (in the case of username1984, user_name_84 etc) usernames and passwords.  A solution to this is so called single-sign on, whereby you use only a single identity such as a Microsoft Passport or a Yahoo! username.  The problem with this solution is that you can find yourself tied in to one large company's services.
  
  If you already have a Microsoft Passport, you are unlikely to want to create a Yahoo! account to use their services as this would involve going through a sign up process, replicating friends lists and so on from one provider to the other etc.  Besides, I don't know about anyone else but I don't like the idea of some large company controlling my identity: storing my username; hashed password and other details.  It would be better if I could arbitrarily choose who controlled my identity, or even better, control it myself.  This is where OpenID comes in.
author_email: max@maxmanders.co.uk
---
We sign up to more and more services online every day.  This often involves remembering multiple, often similar (in the case of username1984, user_name_84 etc) usernames and passwords.  A solution to this is so called single-sign on, whereby you use only a single identity such as a Microsoft Passport or a Yahoo! username.  The problem with this solution is that you can find yourself tied in to one large company's services.

If you already have a Microsoft Passport, you are unlikely to want to create a Yahoo! account to use their services as this would involve going through a sign up process, replicating friends lists and so on from one provider to the other etc.  Besides, I don't know about anyone else but I don't like the idea of some large company controlling my identity: storing my username; hashed password and other details.  It would be better if I could arbitrarily choose who controlled my identity, or even better, control it myself.  This is where OpenID comes in.<!--more-->

Initially created as part of LiveJournal, OpenID is a decentralised user-centric identity management framework.  What this jargon essentially means is that you decide who controls your identity - and there are many places that offer this service.  You can even do it yourself.  An OpenID has to be unique, so the ID would usually be a domain you control, or some other ID provider that would offer an ID like <strong>http://username.serviceprovider.com</strong>.

A traditional web application sign up process would involve completing a form where you select a username; select a password and re-enter it; enter your email address and often verify using email or a CAPTCHA.  You could instead specify your OpenID and forget about selecting a username and password.  The authentication would be delegated to another server, thus decoupling the authentication and identity ownership from any specific site.

When you use OpenID
<ul>
	<li>you tell a site your OpenID (e.g. http://maxmanders.co.uk)</li>
	<li>site parses document referenced by OpenID for specific link elements</li>
	<li>site redirects user to their provider based upon URL found in link elements</li>
	<li>user authenticates to provider</li>
	<li>provider redirects user back to site with evidence that they have been authenticated</li>
</ul>
This is quite a high level overview.  There are a number of redirects and parameters passed between pages, and also some cryptography in the form of a shared secret involved.  This cryptography is required so that the original site (relying site) can be sure that the user who is redirected back has indeed come from and been authenticated by a provider, and not somehow spoofed the request.

What all this means is that you only need to remember your OpenID and the password you chose for a particular provider.  It should be noted that OpenID is in some sense a replacement for the usual username/password combination.  It doesn't inherently offer any more trust than a traditional username/password.  Just as a username/password can be cracked, so too can an OpenID.  The ht difference is that you control the identity, so you can switch providers at any time.  If you feel like your provider is untrustworthy, then use another one or host your own.  This change of provider won't effect how you use your OpenID.

There has also been recent news that both Digg, AOL and possibly even Microsoft intend to use OpenID in current and future products to varying degrees.  We have Digg, the massively popular user contributed bookmarking site which is bound to have a shed load of users; AOL which must have upward of 60 million users and Microsoft (need I say more).  With a potential userbase of this size, OpenID may well be the way forward! It's nice to see cool technologies like this snowballing from the humble geek to the massive multinational company; similar to the way Microformats have emerged. Further information on OpenID can be found on <a href="http://en.wikipedia.org/wiki/Openid" title="Wikipedia: OpenID">Wikipedia</a>, the <a href="http://openid.net" title="openid.net">OpenID official website</a> and <a href="http://simonwillison.net/tags/openid/" title="Simon Willison on OpenID">Simon Willison's blog</a>.
