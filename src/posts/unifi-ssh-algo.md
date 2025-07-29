---
title: accessing older UniFi devices over ssh
description: what to do when you have difficulty connecting to older UniFi kit
permalink: posts/{{ title | slug }}/index.html
date: '2025-07-29'
tags: [tidbit, networks]
---
For some older UniFi devices (those ones you have in the back of the shelf), modern ssh clients might complain when you try and connect to them.

This is relevant when you want to apply custom config to the device, such as setting a specific inform URL.

The SSH client can error out with something like this:
```
no matching host key type found. Their offer: ssh-rsa,ssh-dss
```

The general issue here is the firmware on the device being too old to support all the modern cipher algorithms. OpenSSH (which Windows ships), has had this disabled since v7.0:
[From the legacy changelogs](https://www.openssh.com/legacy.html)
>  OpenSSH 7.0 and greater similarly disable the ssh-dss (DSA) public key algorithm. It too is weak and we recommend against its use. 

The workaround, as suggested by OpenSSH, is to enable the algorithm forcibly:
```console
$ ssh -oHostKeyAlgorithms=+ssh-dss ubnt@<ip>
```

Another error you may encounter is something like this:
```
no matching MAC found.
```
This happens when the client and server can't agree on a MAC algorithm to use. MAC refers to Message Authentication Codes here. 

Same as above, OpenSSH disables old MAC algorithms by default, but we can enable them ourselves.

The final command, with all of our fixes, is this
```console
$ ssh -oHostKeyAlgorithms=+ssh-dss -m hmac-sha1 ubnt@<ip>
```