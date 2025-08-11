---
title: SSLVPN stuck at 98%
description: troubleshooting Fortinet's SSLVPN
permalink: posts/{{ title | slugify }}/index.html
date: '2025-08-11'
tags: [tidbits, networking, fortinet]
---
SSLVPN is one of Fortinet's free VPN offerings, integrating into their firewall hardware, it provides access to your internal network through the firewall.

It does this by provisioning an IP address from the firewall for each client, attached to a virtual ethernet adapter on the device.

![a diagram showing the architecture of the vpn, as described above, in picture form. it shows the traffic flowing through the firewall to an internal server](/images/posts/fortinet/vpn-architecture.png)

This generally works well, though the VPN connection can be unstable with slower networks or networks with unstable latency to the firewall.

## the problem

During a VPN client upgrade, the device was shut down or otherwise disconnected from the internet. This caused the deployment to stall half way through, leaving the client in a very weird state.

The client was uninstalled, but the registry entry for the MSI product was still present, so Windows thought it was still installed. 

This also meant that the virtual adapter was no longer present, because the uninstaller had removed it, and the upgraded client installer would not restore it. The virtual adapter would be found in the "View network connections" Control Panel area.


I suspect this is because the upgraded client detected the "existing" installation and did not want to break it. 

The effect of the adapter being missing is that the VPN connection would never succeed, always timing out after doing its initial handshake and setup. On the firewall side this appears like the client connects, waits 30s and then disconnects. On the client side it gets to 98%, stalls for 30s, then goes back to the login screen.

## the solution

Clearing out the registry entry for the MSI product and rerunning the installer restored the virtual adapter and thus fixed the VPN.

In my case I *had* to mess with the registry because the MSI was removed enough that no standard procedure could clean it up. The uninstall dialogs complained about missing files ([this StackOverflow question](https://stackoverflow.com/questions/334490/uninstall-without-an-msi-file) goes over it), and `msiexec` simply said the product wasn't installed.