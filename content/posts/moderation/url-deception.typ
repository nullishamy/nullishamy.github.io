#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "discord url deception",
    date: "2025-10-16",
    author: "amy erskine",
    summary: [a novel technique for filter bypassing],
    tags: ("moderation",),
)

#show: post.with(..args)

A new novel technique for phishing URLs has come onto my radar recently.

As per other posts (yet to be migrated from my Ghost instance...) I moderate a fairly large Discord server (160k+ members). As a result, we see quite a lot of spam resulting from account takeovers. We believe this is generally from token theft brought about by the popularisation of infostealer malware (and, more recently, selling this as a service so anyone and their nan can get their grubby mits on it).

An interesting side effect of the "MaaS" (Malware as a Service) effect is that we can observe real-time shifts in technique coming from obviously the same users of these services. The URL technique covered today has not yet spread itself out, and we believe that what we are seeing is simply recon to see how effective it is.

So, with the preamble out of the way, let's dive in. 

Firstly, what are the bad actors trying to achieve? In short, they are trying to evade common URL detection and filtering techniques.

We see this changing all the time, generally coming from shifts in infrastructure. Think rotating domain names, IP addresses, cloud hosts, and CDN/proxy services. We do sometimes see shifts in delivery, such as moving the payload from text to images (covered in an upcoming article), and the mentioned URL obfuscator.

This begs the question, how do you obfuscate the URL? One way is using "masked links", a Markdown feature which allows you to obscure the destination of a link. This is generally ok in the context of for example blogs, like this one. My blog is written in Markdown too, so if I write #link("https://example.com")[a masked link] then you will see "a masked link" but the actual destination is https://example.com. However, you can also for example write #link("https://www.youtube.com/watch?v=dQw4w9WgXcQ")[#text("https://google.com")] which will pretend to be google.com whilst in reality being... something else >:3

This starts to fall apart in the context of realtime chat apps. These apps do not *need* link masking, and the security risks greatly outweigh the user benefit, in my humble opinion.

When Discord first introduced link masking, you could write literally what I showed above, a full link mask. They later revised this to "only" allow links without a protocol prefix, though it's shoddy. You can still write a link that looks like this #link("https://example.com")[#text("https//my.evil.domain")]. Without a good look, it would be very easy for an end user to fall for this.

We've seen this link masking being used maliciously for a long while now, ever since it was released, to the point that we simply block it in our server (with some careful filtering for programming concepts!). We don't punish people for posting masked links, other than blocking their message.

Blocking the feature entirely means that if you want to obscure a link in our server, you're going to have to get creative. That's where the novel bypass comes in. It relies on some very specific markdown parse/render behaviour within Discord.

Here's a sample of a link we've seen used in the wild:
```
https:///%6e%65%74%77%6f%72%6b%2d%75%6e%69%73%77%61%70%2e%77%65%62%2e%61%70%70
```

You might be wondering, what the hell is going on here?? This looks _kind of_ link a link, but surely end users would notice the deranged formatting...

They would, if it rendered like you see it here. Unfortunately, Discord actually decodes the urlencoded format and renders it properly. Shown below

#html.img(
    src: "/posts/moderation/link-posted.png",
    alt: "A Discord message posted by me that has the link 'https://network-uniswap.web.app/' in it, which is what gets rendered by Discord instead of the urlencoded garbage described previously",
    title: "The rendered link",
    style: "width: 75%; margin: auto;"
)

The important part of this is the triple slash, `https:///`, this is what allows the urlencoded text to be rendered in the app. I'm truthfully not very sure why this is the case, and would love some relevant specs/info on why this is the way it is.

We can take this one step further, though, abusing another Markdown oddity with Discord. If you wrap your URL in `<>` characters, it's supposed to just remove the embed associated with it. However, it also allows you to spread the URL over multiple lines.

For example
```
<https://
google
.
com>
```
Behaves just like `https://google.com` (though, of course, without the embed).

This can be used in combination with the urlencoded text to evade more primitive filtering techniques.

We can still take this further, though. When using the urlencoded text concept, you can actually mix and match regular text and the urlencoded form. This will again break overly specific filters (such as those looking strictly for repeating % and digit combinations).

Using all of these techniques, we can create this amusing "link":
```
<https:///%68t
%74p
:/
/e
%78a
%6Dp
%6Ce
%2Ec
%6Fm
/t
%65s
%74?
%70a
%
72a
%6D=
%
76a
%
6Cu
%65>
```

Either by chance or by design, you "unfortunately" can't combine link masking with the urlencoding syntax. This is the only good thing Discord has done in terms of their Markdown renderer regarding this.

Naturally, I wrote a script to take a normal link and convert it to this hellish incantation, you can find it #link("https://gist.github.com/nullishamy/ca67c0764f8ae4cede6dde109b6da137")[in a Gist here]. You can of course include parameters in your obfuscated URL, if you wanted tracking info or similar.

We haven't seen this technique taken to the extreme in the real world, though other admins have made online posts showing the `<>` newline technique being used in the past.

In terms of defending from this obfuscation technique, it is actually very simple. You may even have intuited it yourself. Consider that normal, uncompromised users are exceedingly unlikely to be trying to post these obfuscated links. As such, you can simply block that prefix with a regex:
```regex
https:///%.*
```

We have this set to autoban, but you could always play it cautious and use the integrated Automod functionality to hold these messages for moderators to come and take action. This completely neutralises the attack, with server members never even seeing the nasty link.

As noted, however, we have not seen widespread adoption of this technique. Only a handful of accounts coming in to post it. Hopefully it stays this way, but I will be sure to write about any updates!

There's a lot more to cover here, such as the infrastructure surrounding these campaigns, but that's for another time...

