#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "tidbits: a new post series",
    date: "2025-07-29",
    author: "amy erskine",
    summary: [useful knowledge nuggets from me],
    tags: ("tidbits",),
)

#show: post.with(..args)

I plan on writing in this series about little useful tips and tricks I find through my personal and professional experience.
These will include various pieces on syadmining, networking, and whatever else I get up to.

You can find all the posts through the #link("/tags/tidbits")[tidbits tag]
