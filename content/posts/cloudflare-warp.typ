#import "/templates/post.typ": post
#import "/utils/helpers.typ" as utils

#let args = (
    title: "warp madness",
    date: "2025-09-04",
    author: "amy erskine",
    summary: [trials and tribulations of cloudflare warp],
    tags: ("networking", "cloudflare"),
)

#show: post.with(..args)

We all know Cloudflare, right? Our favourite internet monopolist. When going to market for our next web security product, we found Cloudflare's
WARP client. It did it all, web security, SASE, access control, the whole shebang. This would be great, as we were looking to replace our traditional VPN anyways, and with Cloudflare being The Internet Company, we should be in safe hands, right?

If only.

== getting it deployed
The first thing we set out to do was automate our deployment of the agent. We have ~300 user endpoints to do, so automation is a must. We currently use #link("https://www.pdq.com/pdq-deploy/")[PDQ Deploy] for this, a fairly standard tool.

Cloudflare provides an MSI, configured through variables. Great, we'll just set the variables, run the installer and. Oh, we already have our first problem.

#html.img(
    src: "/posts/cloudflare-warp/warp-webview-error.png",
    alt: "an error box which reads 'Microsoft Edge can't read and write to its data directory'",
    title: "The WebView2 error",
    style: "width: 75%; margin: auto;"
)

WARP ideally uses Microsoft's #link("https://developer.microsoft.com/en-us/Microsoft-edge/webview2")[WebView2] to render its sign-in prompts, but when deployed through PDQ, it tries to write into the domain admin account used for installation.

You can use the browser, but if you can get WebView2 working then it can authenticate completely silently (assuming there's a 365 account registered on the device)

If you don't care terribly about a restart, doing one will resolve the problem. Since we are _replacing_ our security tool, we'd rather not run without one until the user decides to restart. We also didn't want to deal with the support requests asking why a random box had appeared.

To get around the permission issues, our deployment does the following:
- Deploy WebView2 through the executable and then enable it for WARP:
```cmd
reg add HKLM\SOFTWARE\Cloudflare\CloudflareWARP /f /v UseWebView2 /t REG_SZ /d y
```
- Run the MSI
- Kill the WARP tray app
- Runs the tray app (as the current logged in user)

If the user isn't logged in, there's nothing to worry about. The tray app will spawn itself when they do.

The #link("https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/deployment/mdm-deployment/parameters")[MSI params] look like this:
```
ORGANIZATION="<our org name>" ONBOARDING="false" AUTO_CONNECT="8"
```

== it's always dns

Phew, now that we're all deployed, things should be a breeze. In fairness, we aren't using an "officially supported tool" for deployment, so that part was at least explainable.

No. DNS is here to ruin your day. For the longest time, we had issues with DNS/WARP interactions. This is technically a configuration fault but there was little helpful guidance from the Cloudflare documentation, from our support partners, or from Cloudflare themselves.

The basic problem is that when WARP gets a DNS request, it will compare with its #link("https://developers.cloudflare.com/cloudflare-one/policies/gateway/resolver-policies/")["Local Resolver Policies"], and route the request accordingly. If no policy matches, then it forwards to 1.1.1.1. To this end, you need to put your corporate domain (Windows domain, that is) into the resolver so it can properly find your internal services.

In theory, you should also be able to use WARP<->WARP tunelling to avoid this issue, but this has never worked properly in our environment. 


== debugging hell

After getting our DNS setup sorted, we embarked on potentially the most frustrating issues yet.

At random, our entire organisation would drop offline. Every machine, disconnected from the internet. If we stopped the WARP service, everyone came back up. This happened 4/5 times within a month, before we were able to at least figure out that changing any settings in the portal would also resolve things, weird.

We left our settings on MASQUE which seemed to halt the outages, and we still have no concrete explanation as to why it did that. The most likely cause is that something causes the daemon to panic out and not recover. This daemon proxies all traffic toward the internet, so when it goes down it takes the device offline with it. Since we're split tunelling the 10.0.0.0/8 subnet, we can still reach it internally.

Everything was then working fine for a few months, until we had our next round of issues to contend with. A combination of the previous 2 issues, like some kind of mutating demon.

At random, individual devices would drop entirely offline. Couldn't reach the internet, couldn't be reached internally. In some cases, users could reach Microsoft products for a short time, but then they would die out too. The logs shows hundreds of entries like this:
```
dns_proxy::resolver: TCP connection to the DoH endpoint timed out (L4 timeout).
```

The only solution was to reboot the machine.

There were numerous other small things too, some websites just not working when proxied, specific apps not working, but those are all minor compared to the rest of the issues faced.

== what next

Well, we are locked in to a 3 year contract so have to stick it out for another 2 at least. We do aim to drop them at the earliest oppurtunity, though.

Aside from all the issues we've had, the real kicker is the lack of support / customer care. Whilst we battled to try and keep everything online, Cloudflare only ever suggested there was issues in our environment that they could not resolve. They have not made any real efforts at this time to help us.

However, based on logs present in recent updates, it does look like they're patching some of the issues we were seeing. Maybe it will improve enough for us to stick with them.

