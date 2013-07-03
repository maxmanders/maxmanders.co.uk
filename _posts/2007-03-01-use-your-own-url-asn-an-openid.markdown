--- 
tags: []

date: 2007-03-01 11:30:04 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/blog/development/use-your-own-url-asn-an-openid/
author: maxmanders
wordpress_id: 37
published: true
layout: post
categories: 
- Development
- OpenID
title: Use Your Own URL As An OpenID
comments: []

author_email: max@maxmanders.co.uk
---
You may already have an OpenID from one of the many providers, for example <em>username.myopenid.com</em>.  Wouldn't it be nice if you could use your own domain name instead?  Well you can!  You may not actually host an identity provider capable of vouching for your ownership of your own domain, but you can always get <em>username.myopenid.com</em> to vouch for you.

This process is called delegation.  You use your own domain name as your OpenID, but add some extra markup to the head element of your homepage that tells the relying party that you are delegating the responsibility of authentication to another server.  The markup you need is:

    <link href="http://www.myopenid.com/server" rel="openid.server" />
    <link href="http://username.myopenid.com/" rel="openid.delegate" />
    <meta http-equiv="X-XRDS-Location" content="http://yoururl.myopenid.com/xrds" />

This will tell the relying party, that it should instead visit <em>username.myopenid.com</em>.  You will then authenticate to this delegate server.  Once successful, by implication of having authenticated to the delegate server, you have also proved that you own the domain from which you were directed.

The link tags are used for OpenID 1.x server discovery, and the meta tag for OpenID 2.x server discover.  In order to be as compatible with OpenID consumers as possible, you should use both link and meta elements.
