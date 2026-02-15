#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "the accounts",
    date: "2026-02-15",
    author: "amy erskine",
    summary: [some analysis of the accounts posting scams],
    tags: ("moderation",),
)

#show: post.with(..args)

After having a look at the #link("/posts/moderation/the-infra")[the infra] behind these scams, let's now do some investigation on the accounts themselves.

I took a sample of the last 120 accounts banned by our automod, and ran some basic analysis on them.

First off, I plotted out the creation dates of each account, which shows no specific pattern. It's not just new users falling for these tricks.

#html.img(
    src: "/posts/spam-analysis/account-creation.png",
    alt: "a bar chart showing a wide range of creation dates",
    title: "account creation dates",
    style: "width: 75%; margin: auto;"
)

I then plotted the account 'flags' (taken from #link("https://flags.lewisakura.moe/")[this amazing resource]) which showed Discord successfully detecting around 16% of the accounts _we_ detected
as spammers. To be frank, this is quite a poor show given just how rampant spam is on the platform. In particular, we know that the 4-panel image gallery is being seen elsewhere, completely
disconnected from tech servers.

#html.img(
    src: "/posts/spam-analysis/flags.png",
    alt: "a bar chart showing the flags present, with the majority being 'no flags', though with a high amount of 'spammer'",
    title: "account flags",
    style: "width: 75%; margin: auto;"
)

Our techniques are fairly primitive really, but have an exceedingly low false positive rate. I would expect an org like Discord to be hitting more than this, perhaps around 50%.

I did also calculate the ban date for each user, based on the message ID of the log, which showed 80 bans for January 2026 (other months are incomplete). This problem is ongoing without a doubt.
