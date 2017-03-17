---
layout: post
title: "GitLabCI With Jekyll And S3"
date: 2017-03-17 21:52:27 +0000
published: true
author: Max Manders
tags:
categories:
---
This site is built using Jekyll. The markdown, and other content, is committed to a Git repository. The Git repository
has its origin remote connected to GitLab, with another remote connected to GitHub for redundancy. The Jekyll site is
built, and the resulting static content is pushed to an AWS S3 bucket. The S3 objects are stored using the reduced
redundancy storage module. All of the content can be readily generated from the Git repository, so I can save money by
choosing the lower redundancy storage model.

I serve the same site on multiple domains. I don't serve HTTP requests directly from the S3 bucket, though this can be
done with the appropriate bucket configuration. If I were to serve the same site on multiple domains using native S3
static hosting, I would need one bucket for each domain, named the same as the domain. This would mean unnecessary cost,
and duplication.

To get around this, I use CloudFront as a CDN, which uses my S3 bucket as its origin. I've created a CloudFront
distribution for each domain. Each distribution is configured to redirect non-SSL requests, and only serve HTTPS
traffic.  SSL is provided via AWS Certificate Manager (ACM). I can create Certificate Signing Requests for each of my
domains, verify the authenticity of those requests, and get SSL certificates from the Amazon Certificate Authority
Certificate Authority, all free of charge! I can then attach each of the certificates to the corresponding CloudFront
distributions.

Finally, all of this is wired together using AWS Route53 for DNS. I have a public zone for each of my domains. Each of
those zones has an ALIAS A record pointing to the appropriate CloudFront distribution. 

This post will focus on how I implement continuous deployment for my site. I'd like to go into more implementation
detail around the wider architecture described earlier, in a separate post. I advocate the use of CloudFormation to
create and manage AWS resources (and the SparkleFormation Ruby DSL) wherever it makes sense. I've created all of this
infrastructure manually. I should really define all of the architecture in CloudFormation. Perhaps I'll do that as part
of a future post.

## Why bother?

My main motivation for implementing CI for this site, was that I wanted to be able to write and publish blog posts
anywhere, with whichever of my devices I had to hand. Let's gloss over the infrequency with which I actually public new
posts or articles, for now! Manually building and deploying my site in a shell session wasn't quite as straight forward
or practical on something like my iPad Pro. Using the approach I describe below, I just need to push a commit to GitLab,
and GitLab CI takes care of the rest. I can write markdown in Vim on my laptop, and push a commit in my shell. Or I can
write a post in Ulysses on my iPad Pro, and then use Working Copy to commit and push it. With either approach, the
result is a newly published post, via GitLab CI.

Before ACM was released, I used CloudFlare. My main motivation for using CloudFlare at the time, was to ensure my site
could serve HTTPS requests. Privacy and security are becoming more important to a wider range of users. Chrome [now
indicates](https://security.googleblog.com/2016/09/moving-towards-more-secure-web.html) if a site is not secure. Even
the Google search engine will [prioritise
ranking](https://webmasters.googleblog.com/2014/08/https-as-ranking-signal.html) of SSL content. If even a handful of
visitors read this post, I feel I have a responsibility to ensure they can read it over a secure connection. CloudFlare
also provided CDN facilities, and DNS management. All of this, as part of a free service tier. I can't fault CloudFlare.
But as an AWS fan, I wanted to have all my eggs in one Amazon basket. With the introduction of ACM, this became a real
possibility.

I also wanted to include a CDN in front of my content, and ensure that all of my domains were HTTPS-friendly, without
duplicating content in S3, or without paying too much for many certificates. The combination of Route 53, CloudFront,
ACM, and S3 fits the bill perfectly, with GitLab CI tying it all together.

## How did I do it?

In the past, I would typically draft a post in Vim on my Macbook Pro. Once I was happy with the post, I could commit it,
and push my changes up to GitHub. I'd use a Rake target to build the static HTML etc. with Jekyll, and push that content
up to an S3 bucket. The Rake target also fixes any permissions or cache expiry settings along the way. However, this
process only really worked for me when I was using my laptop, not other devices like my iPhone or iPad. Furthermore,
this only published changes to maxmanders.co.uk. The www. record for this and my other domains, as well as the zone apex
for my other domains, all served up content in a convoluted mess of S3 buckets doing redirections to other S3 buckets.
Nasty! It should be noted that this is partly owing to the way Route53 ALIAS records for S3 buckets serving static HTML
sites work. The name of the bucket, and the Route53 record, must match. This isn't a problem if the bucket isn't
configured to serve static HTML, and is acting as a CloudFront origin. Route53 can point any name to any CloudFront
distribution.

Editing and committing a post is just fine on any platform. As well as the approach I mentioned above, there are tools I
use on iPhone and iPad for editing, committing and pushing. I use Ulysses to draft a post or article, in markdown. I use
Working Copy to work with Git repositories. Working Copy integrates with Textastic, for working with repository files.
So I create a new file in Working Copy, which opens in Textastic. I can paste the entire post from Ulysses into the
Textastic file, and commit and push upstream from there. The problem really, is building and deploying the changes. This
is where GitLab CI comes in!

### The s3\_website Gem

While you could use the raw AWS APIs, the AWS CLI, or tools like s3cmd to sync a Jekyll site directory with S3, the
[s3_website](https://github.com/laurilehmijoki/s3_website) Gem wraps this all up nicely. This Gem understands hosting
Jekyll, and other site generators, on S3, with CloudFront. It also allows you to configure gzip compression and cache
control, all in a nice YAML config file.

{% highlight yaml linenos %}
s3_id: <%= ENV['ACCESS_KEY_ID'] %>
s3_secret: <%= ENV['SECRET_ACCESS_KEY'] %>
s3_bucket: <%= ENV['S3_BUCKET'] %>
cloudfront_distribution_id: <%= ENV['CLOUDFRONT_DISTRIBUTION_ID'] %>
cloudfront_invalidate_root: true
s3_reduced_redundancy: true
site: public/
max_age:
  "css/*": 604800
  "img/*": 604800
  "js/*":  604800
  "*": 300
cache_control: public, no-transform, max-age=1200, s-maxage=1200
gzip: true
{% endhighlight %}

This is my `s3_website.yml` file, in the root of my Git repository. We'll discuss the environment variables more in the
next section. GitLabCI can interpolate encrypted secrets into this file at build time. It's never wise to commit
secrets!

### GitLabCI

GitLab CI lets you integrate a GitLab repository with GitLab's own continuous integration environment. One of the really
nice things about GitLabCI, is that the pipeline can be defined in a `.gitlab-ci.yml` file in your Git repository root.

I define a Docker image that I'd like to use, to perform the build and deploy. We'll discuss that more in a later
section.

I define a cache directory, that won't be deployed. I install my project dependencies, defined in my Gemfile, using
Bundler. These dependencies are installed into the cache directory.

I define three build stages. GitLabCI executes tasks in different stages, and each task is given both a name, and a
stage. I'm running these tasks in series. I'm sure you can configure tasks to run in parallel. The GitLabCI
documentation is quite comprehensive.

My build stage task, named 'build', is very simple. I build my Jekyll site to a `public/` directory. I also tag this
path as an artifact; this will be used in the later deploy task. This isn't necessarily a deployable artifact, it just
lets me share some output of one build state, with another stage.

I have task between build and deploy. My test task doesn't really test anything, there's not much to test. I use this
stage to export some secrets, for use in the deploy stage. I've called this stage 'vars'. I can create encrypted secrets
in GitLabCI, which can be made available through the build pipeline to my Docker container, as regular `$VARIABLES`. I
write my various secrets out to a file named `s3_deploy_vars` for use in a later stage of the build. As with the build
task, I tag this file as an artifact.

Lastly, comes the deploy task. I constrain this to only execute against commits or merges to the 'master' branch. My
master branch represents the current deployed version of this site. I firstly source the variables defined in the
`s3_deploy_vars` file that was written in the test stage. With these variables available in the environment, I can use
the s3\_website tool to push my site, using the config in `s3_website.yml`.

 {% highlight yaml linenos %}
image: registry.gitlab.com/maxmanders/maxmanders.co.uk:latest

cache:
  paths:
    - /cache

before_script:
  - bundle install --path /cache

stages:
  - build
  - test
  - deploy

build:
  stage: build
  script:
    - JEKYLL_ENV=production bundle exec jekyll build -d public/
  artifacts:
    paths:
      - public

vars:
  stage: test
  script:
    - 'export S3_ID="$(echo "$ACCESS_KEY_ID")" >> s3_deploy_vars'
    - 'export S3_SECRET="$(echo "$SECRET_ACCESS_KEY")" > s3_deploy_vars'
    - 'export S3_BUCKET="$(echo "$S3_BUCKET")" > s3_deploy_vars'
    - 'export CLOUDFRONT_DISTRIBUTION_ID="$(echo "$CLOUDFRONT_DISTRIBUTION_ID")" > s3_deploy_vars'
  artifacts:
    paths:
      - s3_deploy_vars

deploy:
  stage: deploy
  script:
    - source s3_deploy_vars
    - bundle exec s3_website push --force
  artifacts:
    paths:
      - public
  only:
    - master
{% endhighlight %}

###  Docker Build Container
To actually build my content, and publish it, I need somewhere to run those tasks. That used to be my local laptop.
That's not really an option if I don't have my laptop to hand, and I'm using my iPad. This is where the Docker container
comes in. Please note, I'm not a Docker person. I arguably have no idea what I'm doing. This is probably a terrible
Docker file. But it serves my purposes.

I'm starting with the ruby:2.3.3 Docker image, since it has most of what I need. I'm additionally installing Oracle Java
from PPA. The s3\_website Gem has a dependency on Oracle Java for some things. I don't believe these are things I'm
actually using. But I'm going for the pragmatic path of least resistance here. I don't want to reinvent the wheel, or
massage my ego by reimplementing something that somebody else has built perfectly well already. I also need the
`build-essential` and `nodejs` packages.

Once my OS dependencies are installed, I can set a few environment variables that GitLabCI expects. I create the cache
directory that my GitLabCI config file expects, from earlier. I also create a working directory, and make that my
working directory. Once that's done, I can add my repository contents into the project working directory, and install my
Ruby dependencies with Bundler.

{% highlight dockerfile linenos %}
FROM ruby:2.3.3
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/java-8-debian.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 \
    && apt-get update -qq \
    && echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections \
    && apt-get install -y oracle-java8-installer \
       oracle-java8-set-default \
       build-essential \
       nodejs

ENV CI_PROJECT_DIR /builds/maxmanders/maxmanders.co.uk
ENV CI_CACHE_DIR /cache
RUN mkdir -p $CI_PROJECT_DIR $CI_CACHE_DIR
WORKDIR $CI_PROJECT_DIR

ADD Gemfile* $CI_PROJECT_DIR/
RUN bundle install --path $CI_CACHE_DIR

ADD . $CI_PROJECT_DIR
{% endhighlight }
