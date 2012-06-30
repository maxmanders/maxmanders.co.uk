--- 
tags: []

date: 2007-11-03 17:18:42 +00:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/openid/edlug-talk-an-introduction-to-openid/
author: maxmanders
wordpress_id: 69
published: true
layout: post
categories: 
- OpenID
title: EdLUG Talk - An Introduction to OpenID
comments: []

author_email: max@maxmanders.co.uk
---
On Thursday 01 November I gave a brief talk titled "An Introduction to OpenID" at the monthly EdLUG meeting.&Acirc;&nbsp; The <a href="http://www.slideshare.net/maxmanders/an-introduction-to-openid" title="An Introduction to OpenID (Slides).">slides for the talk</a> are available on Slideshare.&Acirc;&nbsp; It seemed to go well despite my fear of public speaking.&Acirc;&nbsp; A few questions were put to me; some of which I could answer.

The few I couldn't answer were mainly regarding the specifics of the OpenID authentication process.&Acirc;&nbsp; Perhaps it was nerves, but in hindsight I realise I knew the answer all along.&Acirc;&nbsp; I was asked if OpenID could tie into Kerberos or PAM.&Acirc;&nbsp; This is really down to how one chooses to implement the standard.

The OpenID specifications state that at at some point authentication must be performed with the Identity Provider.&Acirc;&nbsp; However, the details of how this authentication must be performed are purposefully not specified and instead left up to the implementor.&Acirc;&nbsp; So in answer to the questions, yes you can use Kerberos or PAM in the authentication process, but it's up to&Acirc;&nbsp; you to tie it all together.&Acirc;&nbsp; In fact, traditional username/password combinations need not be used.&Acirc;&nbsp; If one so chooses secure fobs or biometrics could indeed be used; it's up to you!
