---
title: beyond text 
description: using images to scam people
permalink: posts/moderation/{{ title | slugify }}/index.html
date: '2025-11-07'
tags: [moderation]
---
Welcome back for the 3rd post in [this series](/tags/moderation/) in which we will now explore a new threat. Images.

Since we previously explored various textual tactics employed by bad actors, there's been an emergence in using images to deliver the payload.

This completely changes the game of detection and removal as we can no longer use simple string tooling to do our heuristics. Whilst I can't share what we do at TCD, I can at least say that we've solved the problem of images.

There's quite a variety of payloads to look at, so let's get started.

## the tech
It started utilising Discord's CDN as the source for the uploaded images, posting an image link in combination with a masked link, like this:
```
https://media.discordapp.net/attachments/1401868025313103885/1401868063032344648/beast.jpg
I got 3000$ from MrBeast  :thumbsup: 
[bbc.com/news/articles/c74n9wez7k8o](<bad link>)
```

In line with text-based scams, this was of course sprayed everywhere in a server. Our [previously discussed mitigation](/posts/moderation/online-moderation#mitigations) of a blanket masked link ban works wonders here.

There was soon a completely image based variant though, using CDN links again:
```
https://media.discordapp.net/attachments/1294380382661116045/1379563070900408340/1.jpg
https://media.discordapp.net/attachments/1294380382661116045/1379563071206330449/2.jpg
https://media.discordapp.net/attachments/1294380382661116045/1379563071445532855/3.jpg
https://media.discordapp.net/attachments/1294380382661116045/1379563071722229872/4.jpg
```

It is important to highlight that in both cases here CDN **links** are being used. We think this has a few benefits for the bad actors:
1. Server permissions
It's not uncommon for new members to a server to be blocked from posting media. It is however uncommon for *embeds* to also be blocked.
You only need the latter for your CDN links to render.

2. Speed of spray
It takes a long time (relatively) to upload pictures.
It's also not hard to roll the links if it for some reason gets blocked, given how easy Discord servers are to make.

3. Platform integration
Discord will compress the visuals of a CDN link to make it more appealing in the client, this reduces the chances of someone spotting it.

## additional tech
Whilst the core payload remains the same, we've seen yet more rapid development in delivery since initially dealing with the '4 image CDN' variant. 
These include:

1. posting the 3rd party links verbatim
```
https://<bad CDN>/R4HX9jZN/image.png
https://<bad CDN>/1txYh0fn/image.png
https://<bad CDN>/z11zS2W/image.png
https://<bad CDN>/5WCfjZ6X/image.png
```

2. masking those links to a 3rd party CDN
```
[image.png](https://<bad CDN>/d4fhK75V/1.jpg)
[image.png](https://<bad CDN>/v49sDYM7/2.jpg)
[image.png](https://<bad CDN>/hJb1VzC0/3.jpg)
[image.png](https://<bad CDN>/Y43JG9hs/image4.jpg)
```

3. using more markdown hacks to hide the links
I've reduced the amount of pipes for your reading pleasure, but it's about 900 pipes.
```
|||||​|| _ _ _ _ _ _  https://<bad CDN>/UHlJ7jO.png
https://<bad CDN>/BSN8F2m.png
https://<bad CDN>/5R4cvmi.jpeg
https://<bad CDN>/gDr1suT.png
```

## timeline
To provide some context, the rough timeline is this:
- May/June 2025: first sighting
- June -> August 2025: things really pick up
- August 2025 -> Present: most phishes are image based

<img src="/posts/moderation/graph-nov.png" alt="a graph showing the account takeovers in TCD for 2025. it trends up on the back half of the year" title="takeover graph trending up" style="width: 75%; margin: auto;">

## conclusion
The conclusion here is unfortunately dry as I cannot share how we solved this problem. Maybe at some future point we will be able to open source it. 
It will be interesting to see how this technique evolves further, perhaps incorporating more of the URL encoding nonsense [I shared previously](/posts/moderation/discord-url-deception).

I can at least share that our in-house solution now stands at 1665 cases at time of writing, with ~20% of those being the new tech we developed to target this campaign. Pretty strong stuff.
