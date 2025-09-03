---
title: 107240219348-DRAFT warp madness
description: trials and tribulations of cloudflare warp
permalink: posts/{{ title | slugify }}/index.html
date: '2025-09-03'
tags: [networking, cloudflare]

eleventyExcludeFromCollections: true
---
We all know Cloudflare, right? Our favourite internet monopolist. When going to market for our next web security product, we found Cloudflare's
WARP client. It did it all, web security, SASE, access control, the whole shebang. This would be great, as we were looking to replace our traditional VPN anyways, and with Cloudflare being The Internet Company, we should be in safe hands, right?

If only.

## deployment
The first thing we set out to do was automate our deployment of the agent. We have ~300 user endpoints to do, so automation is a must. We currently use [PDQ Deploy](https://www.pdq.com/pdq-deploy/) for this, a fairly standard tool.

Cloudflare provides an MSI, configured through variables. Great, we'll just set the variables, run the installer and. Oh, we already have our first problem.
![an error box which reads "Microsoft Edge can't read and write to it's data directory"](/images/posts/warp/warp-webview-error.png "The WebView2 error")

WARP uses Microsoft's [WebView2](https://developer.microsoft.com/en-us/Microsoft-edge/webview2/) to render its sign-in prompts, but when deployed through PDQ, it tries to write into the domain admin account used for installation.

If you don't care terribly about a restart, this will resolve the problem. Since we are *replacing* our security tool, we'd rather not run without one until the user decides to restart. We also didn't want to deal with the support requests asking why a random box had appeared.

To get around this, our deployment does the following:
- Run the MSI
- Kill the WARP tray app
- Runs the tray app (as the current logged in user)

If the user isn't logged in, there's nothing to worry about. The tray app will spawn itself when they do.

The [MSI params](https://developers.cloudflare.com/cloudflare-one/connections/connect-devices/warp/deployment/mdm-deployment/parameters) look like this:
```
ORGANIZATION="<our org name>" ONBOARDING="false" AUTO_CONNECT="8"
```

## initial setup

Phew, now that we're all deployed, things should be a breeze. In fairness, we aren't using an "officially supported tool" for deployment, so that part was at least explainable.

