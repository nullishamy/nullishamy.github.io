---
title: debugging Window DHCP
description: ipconfig intensifies
permalink: posts/{{ title | slugify }}/index.html
date: '2025-08-19'
tags: [tidbits, networking, windows]
---
If you're managing your DHCP/DNS through your domain controllers, you might sometimes see weirdness in replicated environments.

Just recently I had this scenario:
- Only impacting 1 subnet (call it 10.150.1.0 / VLAN 150)
- No devices anywhere could get a lease
- No leases were active
- Static IPs worked fine

This is our printer network, so we had disabled DHCP at some point to stop badly configured ports and/or "adventureous" users getting IPs on the subnet. 

We then reenabled it to debug something (static IPs not working on the subnet), but found no devices would actually get a lease.

To skip to the good bit, the issue was that one DC thought the subnet was full but the other thought it was empty, so when DHCP requests came in they all got bounced for it being full. 

This was compounded by an oversight in our [IP-Helper](https://networkengineering.stackexchange.com/questions/41376/how-ip-helper-address-works) setup, which was sending all DHCP requests to a single DC. This is critical to check if you are trying to debug DHCP (explored soon), as you won't see any traffic in Wireshark traces if you aren't looking where the requests actually end up!

Once I had located the DC the requests were actually landing at, I could see the DISCOVER but no corresponding OFFER. When looking at other subnets (identified through the origin address, which was their corresponding router), I could see the entire protocol working fine. This at least indicated, combined with a distinct lack of users breaking the door down, that DHCP broadly was intact.

<img src="/images/posts/dhcp/dhcp-proto.png" alt="a diagram showing the normal flow for DHCP. it shows the DISCOVEr, OFFER, REQUEST, and ACKNOWLEDGE communication" title="the flow of DHCP when it is working as intended" style="width: 50%; margin: auto;">

To finally nail down the problem, the Event Log can be used.
Go to **Applications and Services Logs** > **Microsoft** > **Windows** > **DHCP-Server** and select the Admin log. 

In my case it logged clear as day "scope out of leases". We recreated the scope from scratch and everything picked up IPs fine after that. If your scope is actually in use you will want to exercise caution when removing it, as it will invalidate all leases.
