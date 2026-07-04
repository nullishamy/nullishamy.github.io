#import "/templates/post.typ": post
#import "/utils/helpers.typ": parse-date

#let args = (
  title: "the silver mullet to antispam",
  date: parse-date("2026-06-24"),
  author: "amy erskine",
  summary: [an in-depth look at our homegrown antispam],
  tags: ("moderation", "tcd"),
)

#show: post.with(..args)

== what is a silver mullet

Silver Mullet (SM) is our (The Coding Den, TCD) homegrown anti-spam solution built to tackle 
anti-spam at scale. The name comes from a play on the typical "silver bullet" verbiage as this
was not our first attempt at writing such a bot, with previous attempts trying to do too much.

SM was, from the ground up, built around "Keep It Stupid Simple" design methodologies, intially
only cloning our existing bot, Mini Slash, which was written in Crystal. 
Side note: this reimplmentation effort was one of the only times I had to reverse engineer 
a project whilst having access to the entire source code, Crystal developers cannot be 
trusted with terse syntaxes.

To enable this goal of simplicity, we chose to use the same tech stack we use for all other 
bots in TCD. TypeScript with discord.js and Prisma, chosen for its ubiquity and thus 
reduction in #link("https://en.wikipedia.org/wiki/Bus_factor")[the bus factor] for each project.

An additional requirement for the tech choice was that it had to be hostable on a Heroku 
basic runner with plenty of headroom to scale. We did not want to have to pay more money, or
have to rewrite the code, because of resource limitations. 

Whilst JS may seem laughable for this goal, we already had experience with this stack on these runners so we knew the limits. Redis was hosted elsewhere and cached a lot of the data used 
for detection, whilst being independently scalable from the bot itself. This separation of 
concerns also allowed us to recover from a Heroku load balance event without losing our state.

== module 1: CCAS

The first module added to SM was CCAS (cross channel anti spam), which was ported directly
from Mini Slash. It uses #link("https://en.wikipedia.org/wiki/Nilsimsa_Hash")[nilsimsa hashes]
to determine how similar a message is compared to another, whereby if a given message is 
too similar to n previous messages, the author is likely spamming and should be dealt with.

The general implementation looks like this:
```ts
function computeScore(triggerMessage, messageHistory) {
  const threshold = 128 // ported value, indicates identical match
  let score = 0

  for (const message of messageHistory) {
    if (similarity(triggerMessage, message) > threshold) {
      score += 1
    }
  }

  return score > 5
}
```

There is a lot of other logic involved in the computation, such as different scoring depending
on message length, adding score if certain keywords are seen (\@everyone pings, for example),
requiring messages to be above a certain length to be considered, and requiring messages to be
roughly the same size to be considered.

These filters exist so that SM only takes action when there is some level of automated attack
occuring, rather than an overzealous teenager finding the enter key. This is important because
we want to rely on SM banning accounts that pose real risk to the community, such as those 
posting malware, phishing links, etc, rather than 'just' duplicated messages.

Additionally, we don't take the last n messages from someone, but rather a rolling 5 minute 
window of messages. This ensures we get a good balance of visibility without collecting too much
information from people. The messages are expired automatically by Redis.

The full implementation is #link("https://github.com/TheCodingDen/silver-mullet/blob/master/src/detection/spam-detection.ts")[here] if you wish to take a look (spoilers for other subsystems!)

== module 2: regex filtering

Regex is the first module that we implemented outside of the porting effort, with the primary
goal being to thwart spam with even quicker reaction times, in addition to defending against
emerging threats that send far fewer messages. 

The main weakness of CCAS is that it needs to wait until it is confident there is spam occuring 
before it takes action. The durations here are still measured in seconds, but in a "suffering 
from success" style of issue,  community members were flagging spam to the staff team whilst 
the bot was gathering information, thus the action was already taken by the time we came to 
look, wasting our time.

To be clear, we don't have an issue with being summoned for problems, but we are programmers
and can develop a solution to this problem.

The regex module is exactly as simple as you'd expect it to be, taking a list of regexes and
running them against every message the bot sees. The utility comes from the filters themselves,
so let's take a look at some.

To start, we blanket ban a few domains that we consistently saw being linked in messages sent
by compromised accounts. 
These domains are colloquially known as YARLS (yet another russian link shortener), as they
changed often and were based in Russia or countries with similar disregard for the content 
they host.

```
/https?:\/\/u\.to\/\w+/ (g) => BAN
/https?:\/\/lu\.ma\/.+/ (g) => BAN
/https?:\/\/taap\.it\/.+/ (g) => BAN
/https?:\/\/is\.gd\/.+/ (g) => BAN
/https?:\/\/qptr\.ru\/\w+/ (g) => BAN
```

In addition, we ban all Telegram links because we see no genuine use in the community,
but a fair chunk of garbage
```
/https?:\/\/t\.me\/.+/ (g) => BAN
```

Now to get on to some of the more advanced filters. One thing we saw often was 
#link("/posts/moderation/phishing")[a scam designed to take over Steam accounts],
so we filter for any masked link attempting to mask `steamcommunity.com`

```
/\[steamcommunity\.com\/.+\]\(https?:\/\/(?!steamcommunity\.com).+\)/ (g) => BAN
```

NB: we often run 'mirror' regexes for this kind of filter, where the pings come after,
but I will omit these for brevity.

If you read the other post detailing the Steam scam, you may wonder how we filter for messages
that ostensibly never exist, as we block _all_ masked links within TCD, using Discord level 
AutoMod. 

Well, we simply hook it! When Discord fires a log out for the AutoMod action, SM
reads it and applies all the modules it can over it. This means, in theory, an account could
get removed from the server without any messages being visible to the community, entirely
automatically.

In addition to the masking, we also saw a more generic variant, which we match like so
```
/\d+\s*\$\s+gift[\s\S]*https?:\/\/.*/ (g) => BAN
```

This matches messages along the lines of `50$ gift <phishing URL>`. You can see we are starting
to reach the limits of what we can detect with pure textual analysis, it might be time to step
up our game.

== module 3: suspicious reactivation

This module is our crème de la crème, our very best when it comes to detecting phished accounts.
With the shrinking textual context, and increase in 
#link("/posts/moderation/images")[images being used to phish accounts], we needed a more 
behaviour oriented technique to keep false positives close to 0, but false negatives near 100%.

The one unifying behaviour for a lot of these accounts is that they were existing members,
perhaps with a little bit of chat history, but not members that were active by most metrics.

Thus, if we kept track of just the date when each user sent a message, we could know when such
a "suspicious reactivation" has occured.

NB: At the time of writing, we have 15,635 tracked users in the database, around 10% of all 
members.

With this data, each filter could have an additional check added to it, where it would only
activate if the author had not been seen in n days, specified per filter.

Here's what we developed with this
```
/@everyone|@here/ (g) => BAN (30 day inactivity threshold)
/(https?:\/\/.+\.(jpg|jpeg|png)\s*){4}/ (g) => BAN (30 day inactivity threshold)
/(https?:\/\/(i\.)?imgur\.com\/[\s\S]+){4}/ (g) => BAN (30 day inactivity threshold)
/(https?:\/\/)?(discord\.gg|discord\.com\/invite|discordapp\.com\/invite)[\\/].*/ (g) => BAN (30 day inactivity threshold)
```

We chose 30 days for all of our filters, where you'd get banned if you:
- Used a mass mention
- Posted 4 links to some kind of CDN hosting an image
- Posted 4 imgur links (the same as previous, but imgur hides the extension)
- Posed any kind of server invitation

This neutralised the entire class of image scam, without affecting real members.

== module 4: attachment scoring

With the continued rise of images being used in phishing scams, we had to make it attachment 
aware. This is the simplest module of them all, adding 1 point for each attachment posted
outside of the current channel being analysed.

This was an amendment to CCAS, allowing it to respond in as few as 3 messages to this scam.

There were a few iterations to this module, mostly evolving from a "quick and dirty" fix 
into a more stable solution, as we had to respond quickly to the evolving threat.

== other methodologies we tried

We briefly tried out link analysis with Cloudflare Radar, but unfortunately hit bottlenecks 
with speed. Given the nature of the bot, being fully reactive, time to response is very 
important. URLs take a long time to scan, meaning the content stays live for too long.

Additionally, CF wasn't picking up on new bad domains quick enough for it to be reliable.
This is not entirely unexpected, as spammers make new domains every day, but it further 
reduced the value we got from link scanning.

While the feature itself failed, it was still worthwhile to trial and proved that we could 
easily test out new features & expand the bot quickly and safely.

== final points of note 

To finish, I have some other thoughts / points of interest that are worth sharing.

*decancer*

I'd like to give a huge shoutout to #link("https://www.npmjs.com/package/decancer")[the decancer module]
for providing key functionality in an easy to use API.

The TLDR of this module is that it takes all the unicode filter workarounds and normalises them
into ascii. This makes regex filtering much more viable.

*architecture*

A big part of SM was its architecture, where several key factors led to its long term success:
- Keep it stupid simple
- Automated test suites where appropriate, but largely "you can't mock DAPI so don't"
- Keep subsystems as simple as possible and keep them as stateless as possible
- Only cache things where absolutely neccesary, where performance is a proven issue
- Prioritise correctness above all else, recomputing things where it makes the code simpler

In general we designed the modules to match the behaviours we observed, rather than specific 
domains / keywords / etc. This allowed the bot to adapt to slight variations with zero input
from the mod team.

*things i'd like to have changed*

I have very few things I'd have done differently, given I largely built the thing.
However, I'd have preferred some kind of flat config file instead of the slash commands we chose.
Slash commands are just painful in every measurable way and limited what we could do.

For example, we did not implement filter editing because the parameter sets would have been
way too large and difficult to use correctly.

We didn't have many bugs in the end, aside from 1 race condition between us banning and DAPI
processing it, leading to messages being left after the ban. It was on the cards to use our 
message cache to go and clean up, but we never did get around to it.

Oh, and it's #link("https://github.com/TheCodingDen/silver-mullet")[open source now!]