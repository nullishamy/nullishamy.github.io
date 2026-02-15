#import "/templates/post.typ": post, endnote
#import "/utils/helpers.typ" as utils
#import "/utils/callout.typ" as callout

#let args = (
    title: "E2EE, the be all and end all of chat?",
    date: "2026-02-15",
    author: "amy erskine",
    summary: [why a Discord replacement does not need E2EE],
    tags: ("encryption", "privacy", "discord"),
)

#show: post.with(..args)

#callout.note[
    I'm not a cryptographer, but I have a lot of experience in community management, moderation, and have been managing a large Discord for years now. \
    *Don't* trust my takes on crypto, *Do* trust my takes on people.
]

I've seen quite a few posts, blogs and videos contemplating what a Discord replacement would look like, and many propose the idea that they should be E2EE, and that this is
non-negotiable. Here's why I think this idea falls flat.

== It's just not easy to build E2EE at scale

I'm not even going to go into the cryptographic details about how you would achieve such a system, because I'm unqualified and I don't think it's neccesary to prove the point I want to make.

I'll ask just one question: if it were so easy, why isn't it already a thing? Signal is the only serious piece of software to actually do this well, and be approved by cryptographers.

I agree that encrypting things where it's not "strictly neccesary" is fine! HTTPS, for example, is now near-ubiquitous #endnote[https://transparencyreport.google.com/https/overview] thanks to
efforts like LetsEncrypt, but this kind of logic can't be applied when there are serious development implications to add E2EE.

To this end, I will use some anecdotes from 2 people I know who work on #link("https://stoat.chat")[Stoat], the most mature Discord alternative. Here's a few things they are actually struggling with:
1. Getting their apps published
2. Finding developers to work on those apps
3. Platform moderation / spam mitigation
4. Scaling up to handle migrations from Discord

Worrying about E2EE is not even near the list here. Let's now have a look at their work tracker, which is #link("https://op.stoatinternal.com/projects/backend/work_packages")[publically available].
Sorting by priority, here's what they plan on fixing right now, at time of writing:
- Changing out Redis for RabbitMQ for queueing
- Bugs in the event processing pipeline
- Administration tooling
- Bugs relating to users blocking each other

These are things that _users_ are likely to care about.

Performance is obviously very important for realtime applications, administration tooling improves the quality of the platform, and bugs are universally bad, particularly when user safety is involved.

== You'll get scraped anyways

Even if some hypothetical platform does E2EE all user chats, including "guild chats" or whatever equivalent "big public group" concept applies, the fact of the matter is that there will always be scrapers lurking.
Discord has had many panics #endnote[https://www.bitdefender.com/en-gb/blog/hotforsecurity/discord-takes-down-spy-pet-website-that-harvested-data-from-hundreds-of-millions-of-users] #endnote[https://www.404media.co/researchers-scrape-2-billion-discord-messages-and-publish-them-online/]
where data was scraped from the platform.

E2EE does not save you here, because the scrapers can just read your messages! They are the other end of the encryption!

You need to be able to trust the people you are talking to, regardless of whether the chats are encrypted.

This is not to say that E2EE is _useless_, just that in "big public group" contexts, it can be trivially worked around.

The ability for ostensibly random people to pull this off would indicate that a state sponsored campaign would be highly successful, should they deem it neccesary.

== Platform suitability

Others have pointed this out, but I feel it is important to highlight. A Discord-esque platform does not _need_ encryption, in the sense that there are better places to focus our  efforts.

The platform where you play games with your friends and the platform where you arrange 'rage against the machine' can and *should* be different. The issues we're seeing with Discord are not
the lack of E2EE, it's that they're a centralised monopoly hell-bent on their upcoming IPO.

_This_ is what we should focus on changing, _this_ is what real people want to see changed.

Maybe once we have some solution to this tech hell, we can think about E2EE.
