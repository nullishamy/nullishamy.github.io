---
title: restore Windows domain connection
description: reestablish the secure channel through the CLI
permalink: posts/{{ title | slugify }}/index.html
date: '2025-09-05'
tags: [tidbits, windows]
---
I recently discovered [`netdom reset`](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netdom-reset) which is a handy CLI tool to restore the secure channel between a Windows device and its domain controller.

This is useful if you've disabled a device in AD, as that will destroy the channel. Users won't be able to login until you restore it, even after re-enabling the device.

You can run the command like this, from the DC, in an elevated prompt:
```
netdom reset <broken device> /usero:<admin user> /passwordo:<admin password> /domain:<windows domain name>
```
NB: The 'o' at the end of user and password is not a typo.