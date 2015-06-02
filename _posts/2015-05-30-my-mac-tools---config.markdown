---
layout: post
title: "My Mac Tools & Config"
date: 2015-06-02 16:36:12 +0100
published: true
author: Max Manders
tags:
categories:
---
This is necessarily quite a long article with many sections.  The goal of this post is to
share the tools I use on a daily basis to get the job done, and where appropriate, give
some insight into how I use them.  It may prove useful to others who have asked about the
tools I use in the past, or it may prove an interesting retrospective on how things have
changed in years to come.  I've split this article into three main sections, covering the
main desktop apps, web apps, and console tools I use.  While some of these apps and tools
may be available for other Operating Systems, I'm primarily a Mac / OSX user.<!--more-->

* TOC
{:toc}

## Desktop Apps
This section looks at the various desktop apps I use on a daily basis.

### Airmail
I've been a Gmail user for many years now.  Gmail has many benefits, and when used in
the browser with keyboard shortcuts enabled, it's easy to work with great speed and
efficiency.  It also comes with pretty decent spam protection as standard, and nice
integration with other Google Apps products such as Google Drive.  The last few places
I've worked have also used Gmail as their primary email provider.

However, I've always seen email as fulfilling a very specific function, and for the
longest time I've always sent in plain text for maximum portability and interoperability.
While Gmail can add all sorts of _extras_ to email, I still think email can, and should be
a __simple__ exchange of textual information, and nominally sized attachments.  I've also
found that across various browsers, having a Gmail browser tab open all the time can suck
the resources out of my laptop!

To that end, and since Gmail supports IMAP and SMTP secured with SSL and TLS, I use
[Airmail](https://itunes.apple.com/gb/app/airmail-2.1/id918858936?mt=12) as my email
client of choice.  Airmail supports Gmail labels as first-class citizens, and has become
more reliable and stable with each release.  It's a very polished app that supports
individual accounts as well as a unified inbox view if you choose to use it (which I
personally don't).  I should also say that I subscribe to the Inbox Zero approach to
email.  Anything that needs a deferred action or response is sent to Omnifocus for later
triage and archived; anything that requires immediate action is dispatched immediately and
archived; anything that doesn't require any action on my part is archived.  All of my
emails get one or more labels to aid future searching. 

### Fantastical
Along with various other productivity tools, the humble calendar is something I absolutely
rely on; I can't trust my brain to remember everything!  As with Airmail, I rely on Google
Calendar under the hood.  However, I do find it a pain opening and closing a browser tab,
and depending on how many calendars you have delegated access to, it can also become quite
resource hungry in the browser.  I've previously used both Sunrise and
[Fantastical](https://itunes.apple.com/gb/app/fantastical-2-for-iphone-calendar/id718043190?mt=8),
which are both excellent desktop calendar replacements that integrate with Google
Calendar.  If you happen to be an administrator of a Google Apps domain though, you may
find you have delegated access to __a lot__ of calendars.  Fantastical doesn't play nicely
with a massive number of calendars and events, and in that situation, Sunrise is great.  I
do however like Fantastical's interface, and mini-calendar which sits in the menu bar.
    Without myriad delegated calendars, Fantastical wins for me!

### Reeder

I get most of my tech news through Twitter, RSS and Reddit.  Yes, I'm one of the ever
diminishing group of people who still use feed readers!  I used Google Reader for quite a
long time until it was shut down, but quickly came across
[Reeder](https://itunes.apple.com/us/app/reeder-2/id880001334?ls=1&mt=12).  Reeder can
readily import subscriptions from other feed reader services and apps.  It's a beautifully
put together application that supports reading items inline as well as opening in a
browser, and supports sharing items with various other third party services.

### Omnifocus
I'm not sure how I ever got by without Omnifocus, both on the desktop, and mobile devices
(iPhone and iPad).  I've tried to follow a variation of David Allen's [Getting Things
Done](http://en.wikipedia.org/wiki/Getting_Things_Done) methodology for several years now.
I generally find I'm more reliable if the things I'm concerned about aren't rattling about
in my brain, but are instead written down somewhere more resilient than my fleeting
memory.  In doing so, I've tried a number of different tools.  Some have had GTD in mind,
such as the Chandler project; others I've repurposed to fit the GTD approach, such as
Wunderlist and Google Keep.  There is a bit of an upfront cost to these tools, especially
if you want to use Omnifocus on a range of devices.  However, if you're invested in GTD
    then Omnifocus is, in my opinion, a great investment.

#### My Omnifocus Workflow
I typically have three main projects: Home, Personal and Work.  Each of those projects may
in turn contain sequential, parallel or single-action projects for specific short- to
medium-term projects; for example when I recently reviewed a couple of DevOps related
books for Packt Publishing I maintained a project with a task for each chapter to be
reviewed.  Whenever I have a new task to add, I just quick-add it to the Inbox
perspective, and unless it's particularly pressing, it gets categorised as part of my
daily triage.

Each of the main projects contain the same sub-projects, following my modified
interpretation of GTD: Ideas; Single Actions; Daily; Weekly and Monthly.  Ideas reflects
the ‘life goals' or ‘long term' view of GTD; those things that I'd like to do _some day_.
Single Actions is my most oft-used project and contains my most common tasks.  I rarely
assign a specific due date to a task unless there is a very real deadline to the task.
To do otherwise would create a fabricated illusion of urgency.

Instead, I triage my projects on a daily basis.  Those tasks that I'd like to do today get
_flagged_, and in so doing, appear in my Today perspective, along with any tasks that have
a due date of today.  I then complete each tasks, mark them as complete, until I have an
empty Today perspective.  If my Today perspective becomes empty, I can review my projects
again.  I don't tend to use contexts much, I find they add an unnecessary level of detail
for my purposes.

As with Evernote (below), I've found that the more you put in, the more you get out.
Every little twinge of “_Oh, I should really do X”_ or “_I'd better remember to do Y_”
gets added to Omnifocus to avoid any risk of my forgetting to take care of it!

### Evernote
Evernote is my digital, mental, filing cabinet.  The more you put in, and store in it, the
more useful it becomes.  Unless I'm writing something expressly with the intention of
collaborating with others (in which case I might use a shared Google Doc, or a Git
project), it goes in Evernote: meeting notes; project notes; recipes ideas; technical
articles; audio recordings; supporting sketches or screenshots — Evernote can handle it
all.  You can add rich tags to everything in Evernote, which makes finding related content
from disparate sources easy.

Because of Evernote's great tagging facility, I don't need to enforce any artificial
folder hierarchy, in fact I find such a construct less of a help and more of a hindrance.
In a similar fashion to Omnifocus, I have a default _notebook_ called @Inbox (the @ symbol
ensures it's listed near the front of any  other notebooks, and I've just settled into
that naming convention).  Everything goes into there first, to avoid distraction.  I'll
frequently review @Inbox and tag new notes appropriately.  Once tagged, notes are moved
out of @Inbox and into @Cabinet.

There are a number of tools that integrate well with Evernote.  The popular web browsers
have plugins for Evernote that let you clip pages into notebooks.  There's also Clearly,
which takes pages and parses out the content and renders a nice clean note version for
later reading.

### Textual
It may not be as cool as [Slack](https://slack.com) or as hip as
[HipChat](https://www.hipchat.com), but I still find IRC one of the most useful resources
available on the Internet.  Sure, it's nice to know an expert in a particular field, and
have a chat to them about a problem you're working through, but how many of us can say
they can readily contact such an expert?  For most things, there's Google.  But if you're
having trouble succinctly posing a question or query, or if you need some guidance with
some code and a Github Gist would help - IRC is still a fantastic resource.  IRC all comes
with a wonderful sense of community.  Sure, there can be trolls, but they exist
everywhere!  I hang about in various channels on Freenode as ‘maxmanders': typically
##aws; ##devops; #ruby; #chef; #puppet; #vagrant #vim.  The unfortunate thing about IRC is
that once your client disconnects, you're offline, no longer part of the conversation, and
no longer able to receive notifications from other users.  I used to overcome this by
running IRSSI within a GNU screen session on a private server, but now opt to run
[Textual](https://itunes.apple.com/us/app/textual-5/id896450579?mt=12) with an IRC bouncer
(ZNC) on my own Digital Ocean VPS.

Textual is a very polished desktop IRC client for OSX.  It supports the traditional IRC
style commands such as `/join #channel_name` or `/msg <nick> Hello there!`.  Textual also
supports a range of themes and options for being notified, as well as allowing you to
connect to different IRC servers on different networks at the same time.  While Freenode
is the network I'm most familiar with, there are of course many others!

#### ZNC Bouncer
To keep my IRC sessions alive, I use an IRC bouncer.  There are a number of hosted
services, but since I maintain a general purpose VPS on Digital Ocean, I opted to install
the ZNC bouncer on my server.  ZNC allows you to configure connections to different IRC
servers, including default channels to join and which nickname to use.  Instead of
pointing an IRC client such as Textual to e.g. holmes.freenode.net, you'd instead point
your client to your ZNC server, and it takes care of the rest.

### Tweetbot
I don't have a huge amount to say about
[Tweetbot](https://itunes.apple.com/us/app/tweetbot-for-twitter/id557168941?mt=12), other
than it's a great little Twitter client if you're not a huge fan of the stock OSX or iOS
clients.  It supports multiple accounts, and multiple columns for different views on those
account.  You can easily manage curated lists, and view media inline.  Tweetbot also
supports a really polished search interface, as well as the ability to mute tweets based
on hashtags, clients, keywords etc.

### Spotify
I use [Spotify](https://www.spotify.com/), a lot, and I love it.  I've tried Google Play
Music but just didn't get on with the interface that well, and I've always found Spotify
reliable!  It's £9.99 a month, and well worth the cost in my opinion.

### iTerm2
[iTerm2](http://www.iterm2.com) is without a doubt the de-facto standard terminal emulator
for OSX.  While OSX does come preloaded with the Terminal.app application, and can be
    useful in a pinch - iTerm2 is just far more feature rich and useful.  I use iTerm2
    with Tmux, and ZSH/oh-my-zsh.  I use the
    [Solarized](http://ethanschoonover.com/solarized) dark
    [theme](https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized)
    with both iTerm2 and Vim.  

### HipChat
Although not an entirely accurate comparison, you could think of
[HipChat](https://www.hipchat.com) as a simplified IRC for private teams or organisations.
Produced by Atlassian (Confluence, JIRA, Bitbucket etc.)  You can create multiple chat
rooms with specific room topics, giving each room its own owner(s) if you choose.  As
you'd expect, you can also do 1-to-1 private message chats.  Links to many image formats
are rendered inline, and you can upload and share files via a single interface.  There are
a number of plugins and add-ons, including integrations with popular CI tools such as
Bamboo or Jenkins: you could notify a room of a broken build for example.

You can also integrate Bitbucket repositories with different rooms, notifying users of
changes to code: pull requests, pushes to different branches etc.  It's especially useful
in outages where those engineers working to resolve a particular issue can interact
without distraction in a single room, and as a side effect, maintain a real-time record of
what was done and when; very useful for outage post-mortems etc.

HipChat also comes with a very nice API, with
[libraries](https://www.hipchat.com/docs/api/libraries) available in most common
high-level languages.  You can use the API to implement custom notifications to rooms.

### Alfred
Alfred is in many ways similar to the OSX Spotlight.  It can be used as an application
launcher, and a way to open documents by indexing your filesystem.  I've used
[Alfred](http://www.alfredapp.com) for quite a while now, and I'm a paid up PowerPack
user.  It used to be the case that Alfred offered more than the default Spotlight features
of OSX, but with Yosemite, that's not so much the case anymore, certainly not if you use
the _free_ version of Alfred.  Even without the PowerPack features, it's difficult for me
to justify switching back to Yosemite's Spotlight ‘just because'.  I like being able to
use keyword shortcuts such as ‘map' to perform a Google Maps search for example.  However,
I do use the PowerPack features, and really like them.  I use a number of Alfred workflows
so that I can easily launch an RDP session via the Microsoft Remote Desktop Client using
the ‘rdp \<connection name\>' keyword shortcut.  Similarly, I can launch a Viscosity VPN
connection with the ‘visc \<connection name\>' keyword shortcut.  I also really like the
integration with Evernote, which lets me quickly and easily find or create notes with a
single keystroke.

### Bartender
If you've ever found yourself with icons in your OSX menu bar playing hide-and-seek
depending on which application has focus, you're not alone.  Depending on the applications
you've installed, you could end up with an inordinate number of app icons vying to get
noticed.  [Bartender](http://www.macbartender.com) to the rescue.  Bartender allows you to
selectively decide which apps can display their icons in the menu bar, which you'd like to
relegate to a mini-menu tucked inside the Bartender icon, and which you don't care about
enough to display anywhere.

### Dropbox (and Carousel)
I've used the basic Dropbox service for years, mainly as a dumping ground for random
documents, Linux ISOs, etc. Though with the introduction of their Carousel service it's
become more attractive. Carousel is a photo sharing and upload service similar to Flickr
and iPhoto on OSX.  I've found that Carousel has completely replaced iPhoto for most
purposes, and my iPhone and iPad both sync photos taken with Carousel.

### Transmit
[Transmit](http://panic.com/transmit/) is a mature and polished remote file manager that
works with common protocols such as FTP; SFTP; WebDAV and AWS S3.  I use it most
frequently with S3; sure you can use the AWS CLI tools or an interactive Ruby session, but
sometimes you just want to quickly dump a bunch of objects form S3 to your local disk or
vice-versa.  Transmit doesn't get in your way.

### 1Password
[1Password](https://agilebits.com/onepassword) is a simple and convenient password
manager, available for OSX and iOS.  If you're still using variations of a single password
for different services, or short dictionary based passwords, you can instead use 1Password
    to generate arbitrary long and complex passwords, and have it save them for you
    securely.  1Password required a password to unlock, so I'd recommend that the
    passphrase you choose for 1Password is appropriately complex.  There are various posts
    online about strategies for picking complex but easy to remember passphrase.
    1Password can sync its database with e.g. Dropbox to ensure that the same database is
    available to both your laptop and your mobile devices.  There are extensions available
    or common web browsers to allow quick and easy integration by automatically populating
    login forms with credentials stored in 1Password.  The mobile app also integrates with
    Apple's fingerprint reader so you can unlock it once with a passphrase, and then
    simply use your fingerprint thereafter.

### Viscosity
A lot of people use Tunnelblick on OSX as a graphical interface to OpenVPN connections.  I
found it a pain to use and quickly started using
[Viscosity](https://www.sparklabs.com/viscosity/).  Viscosity is a cross-platform OpenVPN
connection manager that just works.  Credentials are stored in the OSX keychain to
securely avoid having to enter a username or password on subsequent connections.  It
supports importing connections either through a local OpenVPN configuration file, or
directly via secure HTTPS connection to an OpenVPN-AS server. 

### Spectacle
If you've come from a Linux background and used tiling window managers such as Ratpoison
before, you'll _get_ Spectacle.  Spectacle is a lightweight app that sits in your menu
bar, and offers shortcuts to arrange windows in useful positions (both keyboard shortcuts
and a popup menu).  You can easily make your applications fullscreen without running them
in a separate OSX space; run e.g. a terminal and a browser side-by-side taking up half the
screen each; have your Skype window running in the lower-left quarter of the screen etc.

## Terminal Tools
I spend a lot of time at a terminal, and any tools I can use to avoid repeating myself and
making my terminal sessions more productive are welcome.  I mentioned iTerm2 above, and in
this section I'll discuss some of the tools I use within iTerm2 to make my life easier.

### Vim
There are myriad text editors and IDEs out there, each with their pro, cons and share of
hardcore fanatics!  I've tried a lot of them, and some are really beautiful and easy to
use.  Sublime Text 2 specifically comes to mind.  But despite such variety, I've continued
to use Vim for almost a decade now.  If you can invest the time to learn Vim properly, and
persevere in developing the muscle memory and Vim mentality, I promise it will serve you
well for everything from editing a long command line to operating as a feature rich IDE
for your programming language of choice!  For example, I regularly use multiple Vim tabs
and split panes, within multiple tmux split windows and panes.  It can be a bit of an
'Inception' problem when you have multiple levels of nesting with split windows, but
once you get use to it, it's incredibly powerful. 

I won't proselytise about Vim at length in this post, there are
[others](http://vimcasts.org) who have done a far better
[job](https://pragprog.com/book/dnvim/practical-vim) at educating people in the
Vim-way!



#### Vundle
I use a lot of plugins with Vim to add functionality.  You can see those that I've loaded
with [Vundle](https://github.com/gmarik/Vundle.vim) in my
[vimrc](https://github.com/maxmanders/vimrc_new/blob/master/.vimrc) file on Github.
Vundle is to Vim what Bundler is to Ruby; and in my opinion supersedes other such plugins
that had a similar goal such as Pathogen.

Vundle allows you to:

  * manage your plugins via your vimrc file
    * install plugins
    * update plugins
    * search for Vim scripts to install, by name
    * clean up unused plugins up

I think my most often used Vim plugin is probably
[ctrlp](https://github.com/kien/ctrlp.vim), with some custom key bindings.  This plugin
allows you to quickly and easily open files in a project with a very powerful search
syntax.  Combined with Ack you can quickly find what you're looking for!

#### vimrc
You can find my vimrc and other Vim related bits and pieces on
[Github](https://github.com/maxmanders/vimrc_new/).

### ZSH
There are a [number](http://fendrich.se/blog/2012/09/28/no/) of
[reasons](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692)
to use ZSH (zee-shell) as your default shell, to mention a few:

  * intuitive tab-completion for lots of things!
    * directory names
    * commands
    * subcommands such as `git c\<tab\>\<tab\>`
      * path expansion
      * useful default aliases for common typos
      * highly configurable prompts
      * command line spelling correction/suggestions
      * and of course, oh-my-zsh

### oh-my-zsh
To quote the maintainer, Robby Russell, [oh-my-zsh](http://ohmyz.sh) is

> “A community-driven framework for managing your zsh configuration.
> Includes 180+ optional plugins (rails, git, OSX, hub, capistrano, brew,
> ant, php, python, etc), over 120 themes to spice up your morning, and an
> auto-update tool so that makes it easy to keep up with the latest updates
> from the community.”

With oh-my-zsh you can layer a lot of new and extended functionality on top of ZSH.  You
can enable a variety of plugins to make working with common tools such as Git, Rake and
many others, easier.  There is also a large selection of themes to choose from to make
your shell informative and pretty!

You can find my various ‘dotfiles' on [Github](https://github.com/maxmanders/dotfiles),
including my zshrc.

### Ack
Grep, a line-oriented regex file searching tool has been around for about forty years.
It's still around, and a key tool in every sysadmins toolbox, which is testament to its
usefulness and longevity!  However, a very fast alternative to grep exists, in the form of
[Ack](http://beyondgrep.com).  Ack is a pure-Perl searching tool, benefiting from Perl's
optimised regex operations.  It's designed to search code, so by default will ignore
common VCS metadata such as Subversion and Git directories.  You can easily specify
filetypes to search in as simple switches such as `--perl` or `--php`.  I still use grep
all the time, but if I find a grep search is taking a while, I'll switch to Ack!

### Tmux
Tmux, like GNU Screen, is a terminal multiplexer.  It allows you to run multiple _virtual_
terminals, arranged within a single window or multiple windows, and easily move between
them.  It's not a drop-in replacement for Screen, and has different key bindings and
features, though for the most part Tmux's features are a superset of Screen's, and the
configuration file is a much nicer to work with in my opinion.

For people moving from screen, a lot of blog posts recommend that one of the first things
you do is rebind the default _prefix_ of ctrl-b to ctrl-a.  I personally haven't done
that, and find I work just as effectively one my fingers got used to using the new prefix.
I've also found that using ctrl-b locally allows you to more easily work with remote
screen sessions that use ctrl-a as the prefix.

### SSH Config
I can't advocate the proper use of SSH config enough.  I've seen a lot of people who have
many shell aliases configured to allow them to SSH to different servers.  Sure, this
works, but isn't that scalable; you also can't implement a proxy command as easily as you
can with SSH config.  SSH config allows you to define a per-user set of host aliases and
options on a per-alias basis, and so much more.  You can easily forward your ssh-agent
meaning that if you use a username and key on a variety of servers in a private network,
you can transparently hop to a server from a bastion host without having to use an awkward
SSH tunnel (agent forwarding should be used carefully, only with networks you trust
absolutely).  You can disable host key checking and map the known\_hosts file to /dev/null
to avoid warnings if you connect to different servers that may have the same private IP
address.  You could use a MasterControl session to reuse the same connection for multiple
servers in the same network, avoiding the overhead of creating new connections.  I'll be
writing a separate post with more detail on SSH tips and tricks, including getting the
most out of SSH config.

### Vagrant
Vagrant is a wonderful application that allows you to quickly and easily define disposable
Virtual Machines using a well defined configuration file.  The ins and outs of Vagrant
deserve their own blog post, or a thorough read of the Vagrant documentation.  But at a
high level, you can write a text config file to define a base box or image; Ruby blocks to
define provisioning strategies such as Chef or Ansible, and use an environment variable to
define which virtualisation platform to use to launch your machine.  The result is a
consistent local environment that's also portable amongst team members.  It's not uncommon
to find a Vagrantfile in a project's source code to allow you to launch a suitably
configured server on which to run the project.  This is especially useful since by
default, Vagrant will mount the current local directory as a shared directory on the guest
machine.  You could write a Rails application, use Chef to install and configure all of
the Rails dependencies, and have a Vagrantfile in the project Git repository.  This would
allow a new contributor to simply check out the code, run `vagrant up` and then be able to
browse to the app using e.g. http://localhost:\<port\>.

### VMWare Fusion
There are quite a few choices out there for v12n: VMWare, KVM, Xen, QEMU, VirtualBox,
Parallels to name a few.  I've settled on VMWare Fusion.  VirtualBox is great, and well
adopted, but I've always found it a little slower than e.g. VMWare Fusion or Parallels.
Parallels on the other hand is blisteringly fast on a Mac but necessarily not
cross-platform.  This portability is somewhat mitigated by using Vagrant as an abstraction
layer.  Having said that, I've found VMWare Fusion to be a good compromise between
portability and performance.

## Web Sites
There are probably a lot more that I use on a daily basis, but the web sites below spring
to mind.

### Github & Bitbucket
You use version control, right?  I mean really, for your application source code, for your
infrastructure code (Chef, Puppet, Ansible etc.), for your dotfiles etc.?  If you don't,
you should!

Github and Bitbucket (from Atlassian) have both been around for a while, and are great
hosted services for Git.  They both offer paid for and free-tier options.  They use subtly
different markdown parsers so commit messages will appear slightly different depending on
whether they are rendered by Bitbucket or Github.  Github has a limit of five private
repositories, and is really geared toward open collaboration and _social coding_.
Bitbucket on the other hand doesn't have a limit on the number of private repositories,
but Github seems to be de-facto standard used by a lot of communities.

Whatever the differences, they both fundamentally offer a hosted Git service!  And if your
project is public, you can and should, use both; Git is decentralised after all.  I've
lost count of the number of times Github has been down and people have been frustrated at
not being able to “…continue with their work…”.  There's nothing stopping you from
carrying on with committing and branching locally.  And when it comes to collaboration,
maintain a separate remote on the other service.  That way, you can push and pull with a
secondary Git service when the primary service is unavailable.

### Pinboard
I've been using [Pinboard](https://pinboard.in) for a little over four years now, and it's
my bookmarking tool of choice.  Since my bookmarks are tagged and stored with Pinboard
rather than locally, I can access them anywhere, from any device.  You can use a very
flexible tagging system to make finding your bookmarks easily.  When I opened my account,
you paid a flat fee based on the number of current users; as the number of subscribers
went up, so too did the cost.  I thought this was a perfectly reasonable and sensible
pricing model.  The current pricing model is just as reasonable for the wonderful service
that Pinboard provides - you pay $11.00 a year.  Simple.

### Bit.ly
Bit.ly is a URL shortening service, and is especially useful if you're reading out URLS
over the phone or pasting something on Twitter.  Every URL you save is reduced to
`http://bit.ly/<small-hash-string>`.  I also use a custom domain with Bit.ly, `maxm.eu`,
which allows me to have a so-called _vanity_ URL for all of my short links.  If you're
interested in clicks, you can review stats on e.g. how often people have clicked on your
short links.
