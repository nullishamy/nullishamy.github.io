#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "restore Windows domain connection",
    date: "2025-09-05",
    author: "amy erskine",
    summary: [reestablish the secure channel through the CLI],
    tags: ("tidbits", "windows"),
)

#show: post.with(..args)

I recently discovered #link("https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netdom-reset")[netdom reset] which is a handy CLI tool to restore the secure channel between a Windows device and its domain controller.

This is useful if you've disabled a device in AD, as that will destroy the channel. Users won't be able to login until you restore it, even after re-enabling the device.

You can run the command like this, from the DC, in an elevated prompt:
```
netdom reset <broken device> /usero:<admin user> /passwordo:<admin password> /domain:<windows domain name>
```
NB: The 'o' at the end of user and password is *not* a typo.
