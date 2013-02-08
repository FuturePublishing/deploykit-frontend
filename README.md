deploykit-frontend
==================

Shiny(ish) webapp that is a front end for mcollective based git deploy tool.

What?
=====

Elsewhere on Github, you should be able to find https://github.com/FuturePublishing/future-deploykit
which contains (mcollective) command-line utilities for inspecting available tags in git repos on 
remote machines and optionally deploying same.

Matt wrote this, which is a Sinatra application and some Twitter Bootstrap bits that makes the 
command-line stuff less scary or less open to abuse, depending on which side of dev or ops you
fall on when pushed.

Why?
====

Deploys that happen rapidly and via a single(ish) click are pretty cool. You should try them.

Wait, 'grabby'?
===============

Beats me. Ask Matt.

Installation.
=============

Copy all the bits that aren't the 'initscript' directory to, er, /data/grabby. Install the initscript
in /etc/init.d and employ whatever tool to create symlinks and ensure sensible ordering.
You will also need an MCollective install that contains a user-login with the right runes to be able
to issue MCollective commands.

You may also require some sort of access-control and/or logging on the relevant webserver. Since we
had an AD install to hand, we used Apache's mod-kerberos, because then user management and p/w sharing
become someone else's problem.

If it all fails dismally, make sure that you can drive your sacrificial/test repository with the 
command-line tools first.
