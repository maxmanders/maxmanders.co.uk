--- 
tags: []

date: 2007-08-16 09:47:42 +01:00
author_login: maxmanders
status: publish
author_url: http://maxmanders.co.uk
wordpress_url: http://maxmanders.co.uk/general/java-this-and-that/
author: maxmanders
wordpress_id: 53
published: true
layout: post
categories: 
- Development
title: Java - this and that
comments: 
- date: Fri Aug 17 16:04:26 +0100 2007
  date_gmt: Fri Aug 17 16:04:26 +0100 2007
  author_url: http://internationalmanofmediocrity.blogspot.com/
  author: Phil
  content: You should probably ask Nick Taylor.
  author_email: phil_nw@yahoo.com
  id: 1318
- date: Fri Aug 17 16:22:04 +0100 2007
  date_gmt: Fri Aug 17 16:22:04 +0100 2007
  author_url: http://maxmanders.co.uk
  author: max
  content: Hehe, I think I'll avoid that route.  I have no intention of picking his brains after the lack of sympathy he gave to those taking Robotics - ouch what a course!  Still I think you drew the short straw with the Java 3D stuff!
  author_email: max@maxmanders.co.uk
  id: 1319
- date: Sun Aug 19 12:02:44 +0100 2007
  date_gmt: Sun Aug 19 12:02:44 +0100 2007
  author_url: http://internationalmanofmediocrity.blogspot.com/
  author: Phil
  content: Yes - this will be the most work you have ever put in for 20% of the course!  And Christian will mark you down by 5%!
  author_email: phil_nw@yahoo.com
  id: 1330
author_email: max@maxmanders.co.uk
---
My work has recently taken a departure from the usual web development as I've been "borrowed" by the other development team to help out with a Java project.  Now, my Java is reasonable sound but yesterday I came across a curious situation involving passing about the current object.

In common with a lot of languages, the current object is represented by the 'this' keyword.  I wanted to pass 'this' to a static method of another class.  Of course, I can't refer to the object as 'this' in the static method context as that would be ambiguous insofar as it could refer to the class with the static method I'm working with.  This pattern is often used with callbacks where for example you might want to register a class with a particular listener objcet.  To avoid confusion, I named the actual parameter in the static method *that*
I assumed that I would reference the fields and methods of the object using
rather than
    this.someMethod()
This is where the fun begins.  Let's call the original object
    SomeObject theObject
and I want to call the static method
    SomeClass.doStaticMethod(SomeObject that)
I would call that method, from within theObject, using
    SomeClass.doStaticMethod(this)
When in theObject, I have access to private fields and methods since private fields and methods are within scope.  I assumed the same would be true when I passed "theObject" as "this" to "SomeClass.doStaticMethod(SomeObject that)".  However, when I actually try to access private fields such as "that.privateField", it would appear that I no longer have access.  I could create appropriate accessor methods, but that would defeat the idea of encapsulation.

Does anyone have any ideas?  Am I missing some fundamental (and so obvious I missed it) rule of scope or object passing?
