---
title: online moderation
description: my experiences moderating a large Discord server
permalink: posts/moderation/{{ title | slugify }}/index.html
date: '2025-04-27'
tags: [moderation]
---
This post was migrated from my Ghost blog instance. Whilst accurate in its reporting, it is not *up to date*

## background
A question wondered by many, given the seemingly mammoth task. Today I will share my little piece of the puzzle and possibly give you some ideas on how you can build the tools of tomorrow.

To start, some background context. I am one of the admins of The Coding Den (TCD), a programming / tech oriented Discord server with 160,000 members at the time of writing. The moderation team has around 15 active members, with 5 being admins.

Our structure is very simple, moderators are responsible just for the day to day stuff, with admins being additionally responsible for the upkeep of the server, the janitors so to speak.

With our staff team, our abilities are quite unique with everyone being very technical, affording us with the ability to develop technical solutions to our moderation problems, unlike most other Discord servers out there.

The biggest problem we've been seeing is malicious account takeovers, wherein a bad actor steals a Discord account and uses it to propagate scams, malware, or other similar campaigns. Most commonly this is a scam targeting Steam, where victims are lured in with "free rewards" for which they get nothing other than malware and a ruined day.

For an idea of the scale of the issue we deal with, it's 5-10 accounts per day on average, though we have observed lulls and equally sharp increases, with the first half of 2024 being the most active since data collection started (start of 2023).

During that period we were frequently above 10 accounts per day and had peaks at 15. This kind of workload is simply impossible to deal with by hand whilst trying to keep response times low to reduce the risk of community members clicking on the scam.

## the hook
To fully understand how these scams manage to fool users we must start at the beginning, the Discord message.

Here's a few samples taken recently:
> @everyone steam gift 50$ - [steamcommunity.com/gift-card/pay/50](<bad domain>)

> steam gives a personal gift - [steamcommunity.com/gifts/id=1131341079](<bad domain>)

> 50$ gift - [steamcommunity.com/105389195](<bad domain>)

There's a few clear patterns in the messages being posted:
1) The lure itself. We can see the "$50 gift" being repeated throughout. This is then reflected on the webpage itself to ensure continuity.
2) Use of "masked links". Discord rolled out this Markdown feature in early 2023, which allows links to obscure their destination. There are only 2 protections in place for this feature.
The first is Discord's "link warning" dialog which checks against known bad domains, forbidding the user from continuing if found. If the domain is not found, it may present a confirmation option which displays the real destination, though the efficacy is debatable as it shows this confirmation on first click of most domains.
The second are restrictions on what can appear in the "visible" portion of the link, which forbids "http(s)", though allows every other part of the link.
<img src="/posts/moderation/discord-click-warn.png" alt="the dialog box informing the user that a known bad domain was clicked, forbidding them from continuing" title="the dialog box informing the user that a known bad domain was clicked, forbidding them from continuing" style="width: 75%; margin: auto;">
3) Though I've hidden them here to avoid *accidents*, lots of the destinations are URL shorteners, often based in Russia, and often being short lived. In the team we jokingly call them YARLS (Yet Another Russian Link Shortener) because of how often we see new ones popping up.

The next phase of the scam is the page itself, assuming it is still active when clicked. We've observed that these domains only last a matter of days before being taken down / blocked by their hosts. This rapid rotation of domains means that in a lot of cases, URL scanning / analysis services are too far behind to reliably detect them.

An interesting side effect of this rotation tactic is that the attackers have to resort to increasingly odd domain names which are close to "steamcommunity.com" (the real domain for Steam). One example of this can be seen in [this scan report](https://radar.cloudflare.com/scan/f064bd20-c33f-44ff-b5ed-3a1991d3c100/summary) where Radar classifies the domain as "DGA" (Domain Generation Algorithm), which would be a much more reliable heuristic to match against.

Once we get to the page, we can see it is very similar to the real steamcommunity page. I have not managed to get one of these pages before they're gone, so can't confirm what the payload is. At a minimum, it must download a credential stealer which then poaches your Discord tokens. I will update this accordingly when I get a sample.

<img src="/posts/moderation/steam-scam-site.png" alt="a screenshot of a steam scam page, featuring a lure for a 50$ 'free credit'" title="a screenshot of a steam scam page, featuring a lure for a 50$ 'free credit'" style="width: 75%; margin: auto;">

## mitigations
Now that we have an idea about the issue and how it presents, what can we do about it? There's two parts to this question, one is the platform itself, the other is our own automod. For hopefully obvious reasons, I won't be documenting our automod filters and methods, but I will outline some general guidance that can be applied to your servers.

Discord has improved tremendously with their platform security in recent time, eliminating whole classes of attack (e.g ping raiding) at the platform level, in addition to providing previously impossible methods of defence for server admins.

One such defence are builtin AutoMod rules (AM going forward to distinguish from other automated systems). With these rules, you can block messages from ever reaching your server, and read those events from a bot to get both granular enforcement programmed as you wish, alongside the power to stop spam ever being sent.

In TCD, we have a [blanket ban](https://docs.thecodingden.net/community-policy-center/faq/moderation#why-did-my-message-get-blocked) on the masked links described above, with a small timeout applied to reduce load on other systems:

Discord has also introduced prebuilt filters into AM which have a decent hit rate, though not perfect. You can set those up to just block and alert to see if it works well in your environment.

There are now additional controls and signals should you experience a raid, including disabling invites and disabling DMs between mutual members (a common vector for spam). We haven't really used these because as noted Discord themselves have stopped such mass spam at the platform level for us.

<img src="/posts/moderation/security-actions.png" alt="The 'Security Actions' pane showing the ability to pause invites and pause DMs between members who share the server but are not friends" title="the security actions pane" style="width: 75%; margin: auto;">

In terms of our own defences, we use [Beemo](https://beemo.gg/) which works well.. when it activates. Beemo is very conservative due to its public nature, so will generally only trip for big raids, but does great work when it finds a raid.

We have also written our own automod bot, Silver Mullet, which uses a variety of standard techniques to automate the banning process for known spam campaigns. As it is our own code, we can adapt it exactly to our needs to allow for quick and efficient response to emerging threats.

Some stats on our bots:
| Bot           | Joined           | Hits |
|---------------|------------------|------|
| Beemo         | 4 years, 1 month | 8244 |
| Silver Mullet | 1 year, 8 months | 793  |

## final thoughts
Even with Discord doing a lot of heavy lifting for us, the account takeovers don't seem to be slowing down. Taken over accounts are getting harder to filter out with conventional means, too, as they are sending less and less with each message which reduces our overall analysis capability. 
