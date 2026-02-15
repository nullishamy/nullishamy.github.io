#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils
#import "/utils/callout.typ" as callout

#let args = (
    title: "Scamming as a Service",
    date: "2026-02-02",
    author: "amy erskine",
    summary: [the infrastructure that powers scams],
    tags: ("moderation",),
)

#show: post.with(..args)

#callout.note[this article is based on some live-posted Discord messages so can't be complete. additionally, I will add to this as I find out more (last changed: #args.date)]

Once upon a time, when we'd received a whole bunch of #link("/posts/moderation/images")[image scams], I decided to investigate the infrastructure behind them, what is actually
going on to power these websites?

What I found was that through trial and error, the same backend infrastructure was powering many disparate operations. Some impersonated Elon Musk, whilst some just advertised generic online
casinos. Their general style was the same, though the Musk frontend had an additional front page to add to the legitmacy.

I found that submitting the same tempmail address to both services yielded a very honest 'email already in use' response from their backend. This of course piqued my interest to see
what else was being shared, what cross-'tenant' boundaries we could have fun with.

Naturally, the first thing was to test authentication across tenants. Unfortunately this does not work :((

The next stage in the signup process was to enter your 'bonus code' or 'promotion code', obtained from the original lure. Interestingly there is validation done on this to ensure you actually
came from a scam. The codes are just "GIFT" or "BONUS" but they are checked, though not tenant-aware! You can use bonus codes from any operation on any other operation without issue.

Once you have some fun with your fake balance you are then prompted to do some "ID Verification" to initiate your withdraw. This will steal your Name, DOB, and Country before then asking you
to fork over some of your own real money to finalise the withdrawl.

You can either pay straight into a BTC wallet (seemingly generated on the fly), or use their fiat => btc helper (https://transak.com/ in this case). I wouldn't advise either though.

To finish, I'm pretty sure their 'live support' is actually live! After trying to use LLM jailbreak prompts, they blacklisted my IP (well, my Mullvad endpoint), from the entire service.
