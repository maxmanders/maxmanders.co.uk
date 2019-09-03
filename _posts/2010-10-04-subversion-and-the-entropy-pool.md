--- 
title: Subversion And The Entropy Pool
layout: post
---

I ran into an interesting little subversion problem earlier. I was trying to commit a change, and the commit just seemed
to hang indefinitely. I couldn't sent an interrupt, and eventually resorted to killing the process. I tried all sorts of
command line options in case there was an authentication problem - with no luck. I then thought I had made a mistake
when switching my working copy to a different branch. I checked the logs on the server to find nothing pertinent; it
seemed as though svn didn't get as far as taking to the server. At a loss, I thought there was nothing for it but to run
the command with strace. Bingo!

<!--more-->

`strace` showed that subversion reads from `/dev/random` as part of the commit, and that's where the problem seemed to be
happening. After doing some research, I discovered that `/dev/random` generates random numbers using the so-called
*entropy pool*. This *entropy pool* is just random bits of noise generated from things such as mouse movements, time
between keystrokes and so on. For whatever reason, on the client server, this *entropy pool* was empty!  Using
`/dev/random` is cryptographically *more random* than using `/dev/urandom`; and `/dev/random` blocks when the *entropy
pool* is empty, whereas `/dev/urandom` is non-blocking. Moving `/dev/random` to `/dev/random.old` and linking
`/dev/urandom` to `/dev/random` solved the problem. There may be a better solution to this, and depending on your
cryptographic requirements it might be better to find an alternative, but this did the trick for me. One svn commit
later and all was well.
